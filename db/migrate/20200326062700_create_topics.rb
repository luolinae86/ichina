class CreateTopics < ActiveRecord::Migration[6.0]
  def change
    create_table :topics, id: false do |t|
      t.string :id, limit: 36, primary_key: true, null: false
      t.string :customer_id
      t.string :topic_type, limit: 20, comment: '帖子类型：need_help(需要帮助):provide_help(提供帮助):report_safe(报平安)'
      t.string :content
      t.string :viewed_count, comment: '被查看了多少次'
      t.string :status, limit: 10, comment: '状态：published(发布):done(完成)'
      t.timestamps
    end
  end
end
