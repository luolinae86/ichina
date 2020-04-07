class CreateTopicThumbsUps < ActiveRecord::Migration[6.0]
  def change
    create_table :topic_thumbs_ups do |t|
      t.string :topic_id, limit: 32
      t.string :user_id, limit: 32
      t.integer :state, default: 0, comment: '0: 1'
      t.timestamps
    end
  end
end

