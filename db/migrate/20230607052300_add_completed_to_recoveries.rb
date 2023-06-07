class AddCompletedToRecoveries < ActiveRecord::Migration[7.0]
  def change
    add_column :recoveries, :completed, :boolean, null: false, default: false
  end
end
