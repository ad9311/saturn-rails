class ExpensesController < ApplicationController
  before_action :set_expense_list
  before_action :set_expense, except: %i[new create]
  before_action :expense_params, only: %i[create update]

  def show; end

  def new
    @expense = Expense.new
  end

  def edit; end

  def create
    @expense = @expense_list.expenses.build(expense_params)
    if @expense.save
      redirect_to expense_list_path(@expense_list)
    else
      render :new
    end
  end

  def update
    if @expense.update(expense_params)
      redirect_to expense_list_path(@expense_list)
    else
      render :edit
    end
  end

  def destroy
    @expense.destroy
    redirect_to expense_list_path(@expense_list)
  end

  private

  def set_expense
    @expense = Expense.find(params[:id])
  end

  def set_expense_list
    @expense_list = ExpenseList.find(params[:expense_list_id])
  end

  def expense_params
    params.require(:expense).permit(:description, :amount)
  end
end
