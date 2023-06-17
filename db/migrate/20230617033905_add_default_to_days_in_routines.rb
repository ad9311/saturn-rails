class AddDefaultToDaysInRoutines < ActiveRecord::Migration[7.0]
  def change
    change_column_default :routines, :days, default: []
  end
end
