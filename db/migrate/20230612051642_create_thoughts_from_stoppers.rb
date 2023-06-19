class CreateThoughtsFromStoppers < ActiveRecord::Migration[7.0]
  def change
    create_table :routines do |t|
      t.references :stopper, null: false, foreign_key: true
      t.references :thought, null: false, foreign_key: true

      t.timestamps
    end
  end
end
