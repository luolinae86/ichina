# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string(255)
#  name                   :string(10)
#  phone                  :string(11)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  sign_in_count          :integer          default(0), not null
#  uuid                   :string(8)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_name   (name)
#  index_users_on_phone  (phone)
#

class User < ApplicationRecord
  depends_on :eat
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable

  before_validation do
    write_attribute(:uuid, SecureRandom.uuid.split('-').first) if new_record? || uuid.blank?
  end

  validates :phone, uniqueness: { message: '手机号已经存在' }
  validate :strong_password

  private

  def strong_password
    errors.add(:password, '密码需要包含小写字母') if (password =~ /[a-z]/).blank?
    errors.add(:password, '密码需要包含大写字母') if (password =~ /[A-Z]/).blank?
    errors.add(:password, '密码需要包含数字')    if (password =~ /[0-9]/).blank?
    errors.add(:password, '长度需要大于等于8')   if password.size < 8
  end
end
