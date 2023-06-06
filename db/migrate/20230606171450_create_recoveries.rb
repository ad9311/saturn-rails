class CreateRecoveries < ActiveRecord::Migration[7.0]
  def change
    create_table :recoveries do |t|
      t.string :title, null: false
      t.text :description
      t.date :start_date, null: false
      t.date :target_date, null: false
      t.jsonb :report_dates, null: false, default: []
      t.integer :record, null: false, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
