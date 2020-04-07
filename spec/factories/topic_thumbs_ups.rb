# == Schema Information
#
# Table name: topic_thumbs_ups
#
#  id           :bigint           not null, primary key
#  state(0: 1)  :integer          default(0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  topic_id     :string(32)
#  user_id      :string(32)
#

FactoryBot.define do
  factory :topic_thumbs_up do
    
  end
end
