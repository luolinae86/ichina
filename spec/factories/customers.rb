# == Schema Information
#
# Table name: customers
#
#  id         :bigint           not null, primary key
#  address    :string(50)
#  nick_name  :string(50)
#  phone      :string(20)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :customer do
    
  end
end