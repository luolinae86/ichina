class AddUuidToTopics < ActiveRecord::Migration[6.0]
  def change
    add_column :topics, :uuid, :string, limit: 32
    add_column :topics, :is_urgent, :boolean, default: false

    add_index :topics, :uuid
  end
end
