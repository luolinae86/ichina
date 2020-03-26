# frozen_string_literal: true

# Useage example
# channel = RabbitMQ.channel
# exchange = channel.direct('gps.exchange', durable: true, queue: :gps)
# exchange.publish({name: :rubychina}.to_json, routing_key: 'gps.key')
# channel.close

# RabbitMQ singleton
class RabbitMQ
  class << self
    def connection
      @connection ||= Bunny.new(Yetting.rabbitmq['mq_connection']).start
    end

    def channel
      @channel = connection.create_channel
    end
  end
end
