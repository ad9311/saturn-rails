class CreateStoppers < ActiveRecord::Migration[7.0]
  def change
    create_table :stoppers do |t|
      t.date :date, null: false
      t.text :reason, null: false
      t.references :recovery, null: false, foreign_key: true

      t.timestamps
    end
  end
end
