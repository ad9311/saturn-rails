class RenameExpenseListsToBudgets < ActiveRecord::Migration[7.0]
  def change
    rename_table :expense_lists, :budgets
  end
end
