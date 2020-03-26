# == Schema Information
#
# Table name: customers
#
#  id         :bigint           not null, primary key
#  address    :string(50)
#  head_url   :string(255)
#  nick_name  :string(50)
#  phone      :string(20)
#  uuid       :string(36)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :customer do
    
  end
end
