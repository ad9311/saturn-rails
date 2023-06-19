class RenameExpenseListsToBudgets < ActiveRecord::Migration[7.0]
  def change
    rename_table :budgets, :budgets
  end
end
