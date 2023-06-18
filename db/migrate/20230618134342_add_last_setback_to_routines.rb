class AddLastSetbackToRoutines < ActiveRecord::Migration[7.0]
  def change
    add_column :routines, :last_setback, :datetime
  end
end
