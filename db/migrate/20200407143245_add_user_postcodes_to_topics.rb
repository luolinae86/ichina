class AddUserPostcodesToTopics < ActiveRecord::Migration[6.0]
  def change
    add_column :topics, :user_postcodes, :string, limit: 32, comment: '邮编'
  end
end
