class RecoveriesController < ApplicationController
  before_action :set_recovery, only: %i[show destroy edit update submit_report renew submit_renew]
  before_action :recovery_params, only: %i[create]
  before_action :recovery_renew_params, only: %i[submit_renew]
  before_action :set_current_date, only: %i[show submit_report]
  before_action :recovery_update_params, only: %i[update]

  def index
    @recoveries = current_user.recoveries
  end

  def show; end

  def new
    @recovery = Recovery.new
  end

  def edit; end

  def create
    @recovery = current_user.recoveries.build(recovery_params)
    if @recovery.save
      redirect_to recovery_path(@recovery)
    else
      render :new
    end
  end

  def submit_report
    redirect_to recovery_path(@recovery) and return unless @current_date >= @recovery.start_date

    last_report = @recovery.report_dates.last&.to_date

    update_report if last_report.nil? || @current_date > last_report

    redirect_to recovery_path(@recovery)
  end

  def renew; end

  def submit_renew
    @recovery.update(**recovery_renew_params, current_record: 0, completed: false)
    redirect_to recovery_path(@recovery)
  end

  def update
    if @recovery.update(recovery_update_params)
      redirect_to recovery_path(@recovery)
    else
      render :edit
    end
  end

  def destroy
    if @recovery.destroy
      redirect_to recoveries_path
    else
      redirect_to recovery_path(@recovery)
    end
  end

  private

  def update_report
    max_record = @recovery.max_record
    current_record_plus = @recovery.current_record + 1
    completed = current_record_plus == @recovery.target_days
    @recovery.update(
      report_dates: @recovery.report_dates.push(Time.zone.now),
      max_record: [current_record_plus, max_record].max,
      current_record: current_record_plus,
      completed:
    )
    return unless completed

    Award.create(
      user: current_user, title: "Completed recovery: #{@recovery.title}",
      awardable: @recovery
    )
  end

  def recovery_params
    params.require(:recovery).permit(:title, :description, :start_date, :target_date)
  end

  def recovery_update_params
    params.require(:recovery).permit(:title, :description)
  end

  def set_recovery
    @recovery = Recovery.find(params[:id])
  end

  def recovery_renew_params
    params.require(:recovery).permit(:start_date, :target_date)
  end

  def set_current_date
    @current_date = Time.zone.now.to_date
  end
end
