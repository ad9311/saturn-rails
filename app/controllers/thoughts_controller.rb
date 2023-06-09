class ThoughtsController < ApplicationController
  before_action :thought_params, only: %i[create]
  before_action :set_thought, only: %i[destroy]

  def index
    @thoughts = current_user.thoughts
  end

  def new
    @thought = Thought.new
  end

  def create
    @thought = current_user.thoughts.build(thought_params)
    if @thought.save
      redirect_to thoughts_path
    else
      render :new
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
