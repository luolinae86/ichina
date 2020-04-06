# == Schema Information
#
# Table name: complaints
#
#  id                                                                                      :string(36)       not null, primary key
#  complaint_type(被投诉的类型(:违法违禁 :色情低俗, :攻击谩骂, :营销广告, :青少年不良信息) :string(20)
#  content                                                                                 :string(255)
#  created_at                                                                              :datetime         not null
#  updated_at                                                                              :datetime         not null
#  topic_id                                                                                :string(255)
#

class Complaint < ApplicationRecord
  belongs_to :topic

  before_create :set_uuid
  def set_uuid
    self.id = SecureRandom.uuid
  end
end
