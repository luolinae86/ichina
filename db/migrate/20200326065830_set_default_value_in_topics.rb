class SetDefaultValueInTopics < ActiveRecord::Migration[6.0]
  def change
    change_column :topics, :status, :string, default: :published
    change_column :topics, :viewed_count, :integer, default: 0
  end
end
