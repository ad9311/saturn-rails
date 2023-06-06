class CreateRecoveries < ActiveRecord::Migration[7.0]
  def change
    create_table :recoveries do |t|
      t.text :description, null: false

      t.timestamps
    end
  end
end
