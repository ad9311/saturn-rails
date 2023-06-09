class ThoughtsController < ApplicationController
  before_action :thought_params, only: %i[create update]
  before_action :set_thought, only: %i[destroy edit update]

  def index
    @thoughts = current_user.thoughts
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

  private

  def thought_params
    params.require(:thought).permit(:message, :mood)
  end

  def set_thought
    @thought = Thought.find(params[:id])
  end
end
