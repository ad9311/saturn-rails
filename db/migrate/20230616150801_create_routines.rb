class CreateRoutines < ActiveRecord::Migration[7.0]
  def change
    create_table :routines do |t|
      t.string :title, null: false
      t.text :description
      t.jsonb :days, null: false
      t.integer :target_days, null: false
      t.integer :current_record, null: false, default: 0
      t.integer :max_record, null: false, default: 0
      t.boolean :completed, null: false, default: false
      t.boolean :bookmarked, null: false, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
