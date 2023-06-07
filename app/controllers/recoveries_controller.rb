class RecoveriesController < ApplicationController
  before_action :set_recovery, only: %i[show submit_report]
  before_action :recovery_params, only: %i[create]

  def index
    @recoveries = current_user.recoveries
  end

  def show; end

  def new
    @recovery = Recovery.new
  end

  def create
    @recovery = current_user.recoveries.build(recovery_params)
    if @recovery.save
      redirect_to recovery_path(@recovery)
    else
      render :new
    end
  end

  def submit_report
    current_date = Time.zone.now.to_date
    last_report = @recovery.report_dates.last&.to_date

    update_report if last_report.nil? || current_date > last_report

    redirect_to recovery_path(@recovery)
  end

  private

  def update_report
    @recovery.update(
      report_dates: @recovery.report_dates.push(Time.zone.now),
      max_record: @recovery.current_record + 1,
      current_record: @recovery.current_record + 1
    )
  end

  def recovery_params
    params.require(:recovery).permit(:title, :description, :start_date, :target_date)
  end

  def set_recovery
    @recovery = Recovery.find(params[:id])
  end
end
