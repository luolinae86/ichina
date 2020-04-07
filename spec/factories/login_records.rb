# == Schema Information
#
# Table name: login_records
#
#  id                         :bigint           not null, primary key
#  create_pin(创建人)         :string(50)       not null
#  sys_version(版本号)        :integer          default(1), not null
#  token(token)               :string(50)       not null
#  update_pin(更新人)         :string(50)       not null
#  user_name(帐号)            :string(20)       not null
#  user_state(0,1)            :integer          default(0)
#  user_type(0)               :integer          default(0)
#  yn(删除标识 0:有效 1:无效) :boolean          default(FALSE)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  user_id                    :string(32)
#

FactoryBot.define do
  factory :login_record do
    
  end
end
