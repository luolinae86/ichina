# == Schema Information
#
# Table name: customers
#
#  id                                   :string(36)       not null, primary key
#  address                              :string(50)
#  head_url                             :string(255)
#  nick_name                            :string(50)
#  openid                               :string(50)
#  phone                                :string(20)
#  social_account(用户发贴用的社交帐号) :string(255)
#  uuid                                 :string(36)
#  created_at                           :datetime         not null
#  updated_at                           :datetime         not null
#  pc_id(PC端的用户ID)                  :string(40)
#

require 'rails_helper'

RSpec.describe Customer, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
