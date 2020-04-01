class CreateComplaints < ActiveRecord::Migration[6.0]
  def change
    create_table :complaints do |t|
      t.integer :topic_id
      t.string :complaint_type, limit: 20, comment: '被投诉的类型(:违法违禁 :色情低俗, :攻击谩骂, :营销广告, :青少年不良信息'
      t.string :content
      t.timestamps
    end
  end
end
