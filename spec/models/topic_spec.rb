# == Schema Information
#
# Table name: topics
#
#  id                                                                                   :string(36)       not null, primary key
#  content                                                                              :string(255)
#  is_urgent                                                                            :boolean          default(FALSE)
#  latitude                                                                             :string(40)
#  longitude                                                                            :string(40)
#  status(状态：published(发布):done(完成))                                             :string(255)      default("published")
#  topic_type(帖子类型：need_help(需要帮助):provide_help(提供帮助):report_safe(报平安)) :string(20)
#  uuid                                                                                 :string(32)
#  viewed_count(被查看了多少次)                                                         :integer          default(0)
#  created_at                                                                           :datetime         not null
#  updated_at                                                                           :datetime         not null
#  customer_id                                                                          :string(255)
#
# Indexes
#
#  index_topics_on_customer_id  (customer_id)
#  index_topics_on_uuid         (uuid)
#

require 'rails_helper'

RSpec.describe Topic, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
