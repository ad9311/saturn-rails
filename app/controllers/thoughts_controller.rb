class ThoughtsController < ApplicationController
  before_action :thought_params, only: %i[create update]
  before_action :set_thought, only: %i[destroy edit update bookmark unbookmark]

  def index
    @thoughts = current_user.thoughts.order(created_at: :desc).page params[:page]
    @bookmarked_thoughts_count = current_user.thoughts.where(bookmarked: true).count
  end

  def new
    @thought = Thought.new
  end

  def edit; end

  def create
    @thought = current_user.thoughts.build(thought_params)
    if @thought.save
      redirect_to thoughts_path
    else
      render :new
    end
  end

  def update
    if @thought.update(thought_params)
      redirect_to thoughts_path
    else
      render :edit
    end
  end

  def destroy
    @thought.destroy
    redirect_to thoughts_path
  end

  def bookmark
    @thought.update(bookmarked: true)

    redirect_to thoughts_path
  end

  def unbookmark
    @thought.update(bookmarked: false)

    redirect_to thoughts_path
  end

  def favorites
    @thoughts = current_user.thoughts.where(bookmarked: true).order(created_at: :desc).page params[:page]
  end

  def destroy_all
    current_user.thoughts.destroy_all
    redirect_to users_account_path
  end

  private

  def thought_params
    params.require(:thought).permit(:message, :mood)
  end

  def set_thought
    @thought = Thought.find(params[:id])
  end
end
