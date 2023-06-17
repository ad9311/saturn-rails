class CorrectDefaultsInTables < ActiveRecord::Migration[7.0]
  def change
    change_column_default :routines, :days, []
    change_column_default :stoppers, :mood, 60
    change_column_default :thoughts, :mood, 60
  end
end
