class RenameBudgetTopAmountAllowedToAmount < ActiveRecord::Migration[7.0]
  def change
    rename_column :budgets, :top_amount_allowed, :amount
  end
end
