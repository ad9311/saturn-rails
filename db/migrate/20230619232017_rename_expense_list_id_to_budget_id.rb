class RenameExpenseListIdToBudgetId < ActiveRecord::Migration[7.0]
  def change
    rename_column :expenses, :expense_list_id, :budget_id
  end
end
