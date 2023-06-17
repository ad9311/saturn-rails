class RoutinesController < ApplicationController
  before_action :set_routine, only: %i[show edit update destroy submit_report bookmark unbookmark]
  before_action :routine_params, only: %i[create update]

  def index
    @routines = current_user.routines.order(created_at: :desc)
    @bookmarked_routines_count = current_user.routines.where(bookmarked: true).count
  end

  def show; end

  def new
    @routine = Routine.new
  end

  def edit; end

  def create
    @routine = current_user.routines.build(routine_params)
    if @routine.save
      redirect_to routine_path(@routine)
    else
      render :new
    end
  end

  def update
    if @routine.update(routine_params)
      redirect_to routine_path(@routine)
    else
      render :edit
    end
  end

  def destroy
    @routine.destroy

    redirect_to routines_path
  end

  def favorites
    @routines = current_user.routines.where(bookmarked: true).order(created_at: :desc)
  end

  def bookmark
    @routine.update(bookmarked: true)
    redirect_to routine_path(@routine)
  end

  def unbookmark
    @routine.update(bookmarked: false)
    redirect_to routine_path(@routine)
  end

  def submit_report
    today = Time.zone.today.strftime('%A').downcase
    current_date = Time.zone.now.to_date
    last_report = @routine.last_report

    redirect_to routine_path(@routine) and return unless @routine.days.include?(today)

    redirect_to routine_path(@routine) and return if !last_report.nil? && last_report.to_date >= current_date

    max_record = @routine.max_record
    current_record_plus = @routine.current_record + 1
    @routine.update(
      max_record: [current_record_plus, max_record].max,
      current_record: current_record_plus,
      last_report: Time.zone.now
    )

    redirect_to routine_path(@routine)
  end

  private

  def set_routine
    @routine = Routine.find(params[:id])
  end

  def routine_params
    params.require(:routine).permit(:title, :description, :target_days, days: [])
  end
end
