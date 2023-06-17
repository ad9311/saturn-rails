class AddLastResportToRoutines < ActiveRecord::Migration[7.0]
  def change
    add_column :routines, :last_report, :datetime
  end
end
