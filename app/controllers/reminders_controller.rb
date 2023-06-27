class RemindersController < ApplicationController
  before_action :set_reminder, only: %i[edit update destroy show]
  before_action :reminder_params, only: %i[create]

  def index
    @reminders = current_user.reminders.order('RANDOM()')
  end

  def show; end

  def new
    @reminder = Reminder.new
  end

  def edit; end

  def create
    @reminder = current_user.reminders.build(reminder_params)
    if @reminder.save
      redirect_to reminders_path
    else
      render :new
    end
  end

  def update
    if @reminder.update(reminder_params)
      redirect_to reminders_path
    else
      render :new
    end
  end

  def destroy
    @reminder.destroy
    redirect_to reminders_path
  end

  def destroy_all
    current_user.reminders.destroy_all
    redirect_to root_path
  end

  private

  def set_reminder
    @reminder = Reminder.find(params[:id])
  end

  def reminder_params
    params.require(:reminder).permit(:message)
  end
end
