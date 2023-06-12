class StoppersController < ApplicationController
  before_action :set_recovery
  before_action :stopper_params, only: %i[create]

  def index
    @stoppers = @recovery.stoppers.order(created_at: :desc)
  end

  def show; end

  def new
    @stopper = Stopper.new
  end

  def create
    @stopper = @recovery.stoppers.build(stopper_params)
    if @stopper.save
      current_date = Time.zone.now.to_date
      today_stoppers = @recovery.stoppers.where(created_at: current_date.all_day).count
      if today_stoppers == 1
        tomorrow = current_date + 1.day
        new_target_date = tomorrow + (@recovery.target_days - 1).days
        @recovery.update(start_date: tomorrow, target_date: new_target_date, current_record: 0)
      end
      redirect_to recovery_path(@recovery)
    else
      render :new
    end
  end

  private

  def set_recovery
    @recovery = Recovery.find(params[:recovery_id])
  end

  def set_stopper
    @recovery = Stopper.find(params[:id])
  end

  def stopper_params
    params.require(:stopper).permit(:reason, :datetime, :mood)
  end
end
