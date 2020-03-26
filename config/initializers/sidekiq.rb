# frozen_string_literal: true

sidekiq_config = { url: ENV['SIDEKIQ_REDIS_URL'] }

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end
