class ImproveRecordInRecoveries < ActiveRecord::Migration[7.0]
  def change
    add_column :recoveries, :max_record, :integer, null: false, default: 0
    rename_column :recoveries, :record, :current_record
  end
end
