class BudgetsController < ApplicationController
  before_action :set_budget, except: %i[index new create]
  before_action :budget_params, only: %i[create update]

  def index
    @budgets = current_user.budgets.order(created_at: :desc)
  end

  def show; end

  def new
    @budget = Budget.new
  end

  def edit; end

  def create
    @budget = current_user.budgets.build(budget_params)
    if @budget.save
      redirect_to budget_path(@budget)
    else
      render :new
    end
  end

  def update
    if @budget.update(budget_params)
      redirect_to budget_path(@budget)
    else
      render :edit
    end
  end

  def destroy
    @budget.destroy
    redirect_to budgets_path
  end

  private

  def set_budget
    @budget = Budget.find(params[:id])
  end

  def budget_params
    params.require(:budget).permit(:title, :top_amount_allowed)
  end
end
