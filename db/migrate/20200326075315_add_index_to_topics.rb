class AddIndexToTopics < ActiveRecord::Migration[6.0]
  def change
    add_column :topics, :latitude, :string, limit: 15
    add_column :topics, :longitude, :string, limit: 15
    add_index :topics, :customer_id
  end
end
