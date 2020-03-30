# == Schema Information
#
# Table name: customers
#
#  id                                   :bigint           not null, primary key
#  address                              :string(50)
#  head_url                             :string(255)
#  nick_name                            :string(50)
#  openid                               :string(50)
#  phone                                :string(20)
#  social_account(用户发贴用的社交帐号) :string(255)
#  uuid                                 :string(36)
#  created_at                           :datetime         not null
#  updated_at                           :datetime         not null
#

FactoryBot.define do
  factory :customer do
    
  end
end
