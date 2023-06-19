class RenameBudgetTopAmountAllowedToAmount < ActiveRecord::Migration[7.0]
  def change
    rename_column :budgets, :amount, :amount
  end
end
