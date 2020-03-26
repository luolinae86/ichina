# frozen_string_literal: true

RuCaptcha.configure do
  # 配置 cache_store，类似 Rails 的 config.cache_store
  # 与其它的验证码库不同， RuCaptcha 将验证码 code 存放在后端，而不是 Session，以避免 Session 重放攻击
  # 你需要将 cache_store 配置在一个支持跨进程、跨服务器共享的地方，例如 Memcached, Redis 都可以
  # 不可以用 file_store, null_store 或者 memory_store
  # 因为这些存储方式无法跨进程或服务器，当多进程、服务器部署的时候验证码会验证不过。
  self.cache_store = if ENV.fetch('RAILS_ENV') == 'development'
                       :redis_store
                     else
                       [:redis_store, ENV['SIDEKIQ_REDIS_URL']]
                     end
end
