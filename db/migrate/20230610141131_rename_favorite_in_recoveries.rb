class RenameFavoriteInRecoveries < ActiveRecord::Migration[7.0]
  def change
    rename_column :recoveries, :favorite, :bookmarked
  end
end
