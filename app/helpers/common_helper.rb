# frozen_string_literal: true

module CommonHelper
  def notify_address(rider_phone, address)
    "你的外卖已到达：#{address}, 骑手电话: #{rider_phone}"
  end

  def notify_extension_address(rider_phone, extension_phone, address)
    "##{extension_phone}#你的外卖已到达：#{address}, 骑手电话: #{rider_phone}"
  end

end
