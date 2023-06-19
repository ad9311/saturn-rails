class CreateExpenseLists < ActiveRecord::Migration[7.0]
  def change
    create_table :budgets do |t|
      t.string :title, null: false
      t.float :total_expenses, null: false, default: 0.0
      t.float :top_amount_allowed, null: false
      t.float :balance, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
