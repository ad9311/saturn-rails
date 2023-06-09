class AddNewDefaultToMoodInStoppers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :stoppers, :mood, default: 60
  end
end
