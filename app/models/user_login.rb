# frozen_string_literal: true

# == Schema Information
#
# Table name: user_logins
#
#  id         :bigint           not null, primary key
#  ip         :string(20)
#  phone      :string(11)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class UserLogin < ApplicationRecord
end
