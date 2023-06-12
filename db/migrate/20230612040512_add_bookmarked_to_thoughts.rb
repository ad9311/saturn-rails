class AddBookmarkedToThoughts < ActiveRecord::Migration[7.0]
  def change
    add_column :thoughts, :bookmarked, :boolean, null: false, default: false
  end
end
