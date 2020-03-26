# frozen_string_literal: true

# docker config
# opts = {
#   daemonize: true,
#   amqp: Yetting.rabbitmq['mq_connection'],
#   log: 'log/sneakers.log',
#   pid_path: 'tmp/pids/sneakers.pid',
#   threads: 1,
#   workers: 1
# }

# mina config

pid_path = 'tmp/pids/sneakers.pid'
pid_path = '/home/deployer/wai_mai/tmp/pids/sneakers.pid' if Rails.env.production?

opts = {
  daemonize: true,
  amqp: Yetting.rabbitmq['mq_connection'],
  log: 'log/sneakers.log',
  pid_path: pid_path,
  threads: 1,
  workers: 1
}

Sneakers.configure(opts)
Sneakers.logger.level = Logger::INFO
