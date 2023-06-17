class RoutinesController < ApplicationController
  before_action :set_routine, only: %i[show edit update destroy bookmark unbookmark]
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

  private

  def set_routine
    @routine = Routine.find(params[:id])
  end

  def routine_params
    params.require(:routine).permit(:title, :description, :target_days, days: [])
  end
end
