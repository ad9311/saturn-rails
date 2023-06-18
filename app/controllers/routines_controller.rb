class RoutinesController < ApplicationController
  before_action :set_routine, only: %i[show edit update destroy submit_report submit_setback bookmark unbookmark new_target submit_new_target]
  before_action :routine_params, only: %i[create update]
  before_action :routine_new_target_params, only: %i[routine_new_target_params]

  include Awards
  include RoutineHelper

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
    redirect_to routine_path(@routine) and return unless allow_submit_routine_report?(@routine)

    update_report
    redirect_to routine_path(@routine)
  end

  def submit_setback
    redirect_to routine_path(@routine) and return unless allow_submit_routine_setback?(@routine)

    current_record_minus = @routine.current_record - 1
    @routine.update(last_setback: Time.zone.now, current_record: current_record_minus)
    redirect_to routine_path(@routine)
  end

  def new_target
    redirect_to routine_path(@routine) and return unless @routine.completed?
  end

  def submit_new_target
    redirect_to routine_path(@routine) and return unless @routine.completed?

    if @routine.update(**routine_new_target_params, current_record: 0, completed: false)
      puts "#################################"
      puts @routine.completed?
      puts "#################################"
      redirect_to routine_path(@routine)
    else
      render :new_target
    end
  end

  private

  def update_report
    max_record = @routine.max_record
    current_record_plus = @routine.current_record + 1
    completed = current_record_plus == @routine.target_days
    @routine.update(
      max_record: [current_record_plus, max_record].max,
      current_record: current_record_plus,
      last_report: Time.zone.now,
      completed:
    )

    return unless completed

    tier = calculate_tier(@routine.target_days)
    Award.create(
      user: current_user,
      title: "Completed routine's target: #{@routine.title}",
      awardable: @routine,
      tier:
    )
  end

  def set_routine
    @routine = Routine.find(params[:id])
  end

  def routine_params
    params.require(:routine).permit(:title, :description, :target_days, days: [])
  end

  def routine_new_target_params
    params.require(:routine).permit(:target_days, days: [])
  end
end
