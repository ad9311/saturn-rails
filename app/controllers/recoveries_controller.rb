class RecoveriesController < ApplicationController
  before_action :set_recovery, only: %i[show]
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
      redirect_to recoveries_path
    else
      redirect_to new_recovery_path
    end
  end

  private

  def recovery_params
    params.require(:recovery).permit(:title, :description, :start_date, :target_date)
  end

  def set_recovery
    @recovery = Recovery.find(params[:id])
  end
end
