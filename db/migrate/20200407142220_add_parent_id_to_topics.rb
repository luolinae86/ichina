class AddParentIdToTopics < ActiveRecord::Migration[6.0]
  def change
    add_column :topics, :parent_id, :string, limit: 32, comment: '关联帖子ID'
    add_column :topics, :up_count , :integer, default: 0, comment: '点赞次数'
    add_column :topics, :down_count , :integer, default: 0, comment: '被踩次数'
  end
end
