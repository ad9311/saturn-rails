class AddNewDefaultToMoodInThoughts < ActiveRecord::Migration[7.0]
  def change
    change_column_default :thoughts, :mood, default: 60
  end
end
