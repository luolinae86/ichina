# frozen_string_literal: true

module RabbitMqHelper
  # 给用户真实号码发送短信
  def sms_to_mq(messages)
    channel = RabbitMQ.channel
    exchange = channel.direct('sms.exchange', durable: true, queue: :sms)
    messages.each do |msg|
      exchange.publish(msg.to_json, routing_key: 'sms.key')
    end
    channel.close
  end

  # 对用户开启了隐私号的，发送虚拟号，带扩展号的短信（美团4位，饿了么3位)
  def sms_extension_to_mq(messages)
    channel = RabbitMQ.channel
    exchange = channel.direct('sms_extension.exchange', durable: true, queue: :sms_extension)
    messages.each do |msg|
      exchange.publish(msg.to_json, routing_key: 'sms_extension.key')
    end
    channel.close
  end

  def voice_to_mq(messages)
    channel = RabbitMQ.channel
    exchange = channel.direct('voice.exchange', durable: true, queue: :voice)
    messages.each do |msg|
      exchange.publish(msg.to_json, routing_key: 'voice.key')
    end
    channel.close
  end

  # 对用户开启了隐私号的，发送虚拟号，带扩展号的语音（美团4位，饿了么3位)
  def voice_extension_to_mq(messages)
    channel = RabbitMQ.channel
    exchange = channel.direct('voice_extension.exchange', durable: true, queue: :voice)
    messages.each do |msg|
      exchange.publish(msg.to_json, routing_key: 'voice_extension.key')
    end
    channel.close
  end

  def flash_to_mq(messages)
    channel = RabbitMQ.channel
    exchange = channel.direct('flash.exchange', durable: true, queue: :flash)
    messages.each do |msg|
      exchange.publish(msg.to_json, routing_key: 'flash.key')
    end
    channel.close
  end
end
