class AddDefaultToMoodInThoughts < ActiveRecord::Migration[7.0]
  def change
    change_column_default :thoughts, :mood, default: 0
  end
end
