# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id                                                     :bigint           not null, primary key
#  address(订单的送货地址)                                :string(50)
#  created_time(订单创建时间)                             :integer
#  customer_name(顾客姓名)                                :string(255)
#  customer_phone(顾客电话)                               :string(20)
#  day_seq(商家当天的流水号)                              :string(5)
#  discounted_fee(折扣了多少钱)                           :float(24)
#  last_four_number(用户四位手机号)                       :string(4)
#  latitude(纬度)                                         :string(15)
#  longitude(经度)                                        :string(15)
#  lunch_box_fee(餐盒费)                                  :float(24)
#  merchant_name(商家名)                                  :string(50)
#  merchant_phone(商家电话)                               :string(50)
#  original_price(订单原价多少钱)                         :float(24)
#  paid_price(订单支付了多少)                             :float(24)
#  quantity(数量)                                         :integer
#  record_date                                            :integer
#  remarks(用户备注)                                      :string(255)
#  rider_phone(骑手是谁)                                  :string(255)
#  shipping_fee(配送费)                                   :float(24)
#  source                                                 :string(20)
#  status(init: 初始化, shipping: 配送中, done: 完成配送) :string(20)       default("init")
#  updated_time(订单更新时间)                             :integer
#  uuid                                                   :string(32)
#  created_at                                             :datetime         not null
#  updated_at                                             :datetime         not null
#  box_id(这个订单会放到哪个配送大盒子里面)               :integer          default(0)
#  customer_id                                            :integer
#  inner_order_id(订单ID，注意和记录order的主键ID不同)    :string(50)
#  merchant_id                                            :integer
#  outer_order_id(订单展示ID，用户下单时看到的id)         :string(50)
#  rider_id(谁在配送这个单子)                             :integer          default(0)
#
# Indexes
#
#  index_orders_on_box_id            (box_id)
#  index_orders_on_created_at        (created_at)
#  index_orders_on_customer_name     (customer_name)
#  index_orders_on_customer_phone    (customer_phone)
#  index_orders_on_inner_order_id    (inner_order_id)
#  index_orders_on_last_four_number  (last_four_number)
#  index_orders_on_merchant_name     (merchant_name)
#  index_orders_on_merchant_phone    (merchant_phone)
#  index_orders_on_outer_order_id    (outer_order_id)
#  index_orders_on_record_date       (record_date)
#  index_orders_on_rider_phone       (rider_phone)
#  index_orders_on_uuid              (uuid)
#  rider_id_record_date              (rider_id,record_date)
#

class Order < ApplicationRecord
  has_many :menus
  has_one :notification
  belongs_to :merchant
  belongs_to :customer
  belongs_to :rider
  belongs_to :box

  validates_presence_of :inner_order_id, message: 'inner_order_id is needed'
  validates_presence_of :outer_order_id, message: 'outer_order_id is needed'
  validates_presence_of :source, message: 'source is needed'

  validates_presence_of :customer_name, message: 'customer_name is needed'
  validates_presence_of :customer_phone, message: 'customer_phone is needed'

  validates_presence_of :merchant_name, message: 'merchant_name is needed'
  validates_presence_of :merchant_phone, message: 'merchant_phone is needed'

  scope :with_init, -> { where(status: 'init') }
  scope :with_shipping, -> { where(status: 'shipping') }
  scope :with_done, -> { where(status: 'done') }
  scope :with_merchant_name, ->(merchant_name) { merchant_name.present? ? where(merchant_name: merchant_name) : all }
  scope :with_outer_order_id, ->(outer_order_id) { where(outer_order_id: outer_order_id) }
  scope :with_rider_id, ->(rider_id) { where(rider_id: rider_id) }
  scope :with_box_id, ->(box_id) { where(box_id: box_id) }
  scope :with_customer_phone, ->(customer_phone) { where(customer_phone: customer_phone) }
  scope :with_rider_phone, ->(rider_phone) { where(rider_phone: rider_phone) }
  scope :with_last_four_number, ->(last_four_number) { where(last_four_number: last_four_number) }
  scope :with_record_date, ->(record_date) { where(record_date: record_date) }
  scope :with_rider_id_record_date, ->(rider_id, record_date) { where(rider_id: rider_id, record_date: record_date) }

end
