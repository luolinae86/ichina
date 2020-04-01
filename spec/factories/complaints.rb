# == Schema Information
#
# Table name: complaints
#
#  id                                                                                      :bigint           not null, primary key
#  complaint_type(被投诉的类型(:违法违禁 :色情低俗, :攻击谩骂, :营销广告, :青少年不良信息) :string(20)
#  content                                                                                 :string(255)
#  created_at                                                                              :datetime         not null
#  updated_at                                                                              :datetime         not null
#  topic_id                                                                                :integer
#

FactoryBot.define do
  factory :complaint do
    
  end
end
