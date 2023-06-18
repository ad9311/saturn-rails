class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.boolean :archived, null: false, default: false
      t.float :amount
      t.string :description
      t.references :expense_list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
