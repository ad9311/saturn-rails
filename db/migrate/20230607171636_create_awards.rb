class CreateAwards < ActiveRecord::Migration[7.0]
  def change
    create_table :awards do |t|
      t.string :title, null: false
      t.string :awardable_type
      t.integer :awardable_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
