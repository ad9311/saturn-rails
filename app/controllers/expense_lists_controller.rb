class ExpenseListsController < ApplicationController
  before_action :set_expense_list, except: %i[index new create]
  before_action :expense_list_params, only: %i[create update]

  def index
    @expense_lists = current_user.expense_lists.order(created_at: :desc)
  end

  def show; end

  def new
    @expense_list = ExpenseList.new
  end

  def edit; end

  def create
    @expense_list = current_user.expense_lists.build(expense_list_params)
    if @expense_list.save
      redirect_to expense_list_path(@expense_list)
    else
      render :new
    end
  end

  def update
    if @expense_list.update(expense_list_params)
      redirect_to expense_list_path(@expense_list)
    else
      render :edit
    end
  end

  def destroy
    @expense_list.destroy
    redirect_to expense_lists_path
  end

  private

  def set_expense_list
    @expense_list = ExpenseList.find(params[:id])
  end

  def expense_list_params
    params.require(:expense_list).permit(:title, :top_amount_allowed)
  end
end
