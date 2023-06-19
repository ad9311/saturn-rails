class ExpensesController < ApplicationController
  before_action :set_budget
  before_action :set_expense, except: %i[new create]
  before_action :expense_params, only: %i[create update]

  def show; end

  def new
    @expense = Expense.new
  end

  def edit; end

  def create
    @expense = @budget.expenses.build(expense_params)
    if @expense.save
      redirect_to budget_path(@budget)
    else
      render :new
    end
  end

  def update
    if @expense.update(expense_params)
      redirect_to budget_path(@budget)
    else
      render :edit
    end
  end

  def destroy
    @expense.destroy
    redirect_to budget_path(@budget)
  end

  private

  def set_expense
    @expense = Expense.find(params[:id])
  end

  def set_budget
    @budget = Budget.find(params[:budget_id])
  end

  def expense_params
    params.require(:expense).permit(:description, :amount)
  end
end
