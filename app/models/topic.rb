# == Schema Information
#
# Table name: topics
#
#  id                                                                                   :bigint           not null, primary key
#  content                                                                              :string(255)
#  is_urgent                                                                            :boolean          default(FALSE)
#  latitude                                                                             :string(15)
#  longitude                                                                            :string(15)
#  status(状态：published(发布):done(完成))                                             :string(255)      default("published")
#  topic_type(帖子类型：need_help(需要帮助):provide_help(提供帮助):report_safe(报平安)) :string(20)
#  uuid                                                                                 :string(32)
#  viewed_count(被查看了多少次)                                                         :integer          default(0)
#  created_at                                                                           :datetime         not null
#  updated_at                                                                           :datetime         not null
#  customer_id                                                                          :integer
#
# Indexes
#
#  index_topics_on_customer_id             (customer_id)
#  index_topics_on_latitude_and_longitude  (latitude,longitude)
#  index_topics_on_uuid                    (uuid)
#

class Topic < ApplicationRecord
  acts_as_mappable default_units: :kms, lat_column_name: :latitude, lng_column_name: :longitude

  belongs_to :customer

  scope :with_uuid, ->(uuid) { where(uuid: uuid) }
  scope :with_status, ->(status) { where(status: status) }
  scope :with_customer_id, ->(customer_id) { where(customer_id: customer_id) }
  scope :with_topic_type, ->(topic_type) {topic_type.present? ? where(topic_type: topic_type) : all }

end
