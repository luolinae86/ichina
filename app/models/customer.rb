# frozen_string_literal: true

# frozen_string_litaral: true

# == Schema Information
#
# Table name: customers
#
#  id                             :bigint           not null, primary key
#  hiden_phone(顾客名)            :string(20)
#  last_four_number(手机号后四位) :string(4)
#  name(顾客名)                   :string(50)
#  phone(顾客名)                  :string(20)
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#
# Indexes
#
#  index_customers_on_last_four_number  (last_four_number)
#  index_customers_on_name              (name)
#  index_customers_on_phone             (phone)
#

class Customer < ApplicationRecord
  has_many :orders

  validates_presence_of :name, message: 'name is needed'
  validates_presence_of :phone, message: 'phone is needed'
end
