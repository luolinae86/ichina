class ChangeLatitudeInTopics < ActiveRecord::Migration[6.0]
  def change
    change_column :topics, :latitude, :string, limit: 40
    change_column :topics, :longitude, :string, limit: 40
  end
end
