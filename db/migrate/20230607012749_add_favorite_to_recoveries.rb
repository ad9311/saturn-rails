class AddFavoriteToRecoveries < ActiveRecord::Migration[7.0]
  def change
    add_column :recoveries, :favorite, :boolean, null: false, default: false
  end
end
