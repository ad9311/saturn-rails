class ChangeDateToDatetimeInStoppers < ActiveRecord::Migration[7.0]
  def change
    rename_column :stoppers, :date, :datetime
    change_column :stoppers, :datetime, :datetime
  end
end
