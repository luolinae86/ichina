# frozen_string_literal: true

source 'https://gems.ruby-china.com/'
ruby '2.6.4'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'dotenv-rails'

gem 'devise'
gem 'font-awesome-rails'

gem 'rails', '~> 6.0.0'

gem 'puma'
gem 'unicorn'

gem 'mina'
gem 'mina-sidekiq', require: false
gem 'mina-unicorn', require: false

gem 'sprockets'

gem 'grape'
gem 'grape-entity'
gem 'grape-swagger'
gem 'grape-swagger-entity'
gem 'grape-swagger-rails'
gem 'grape_logging'
gem 'grape_on_rails_routes'

gem 'mysql2'

gem 'yettings'

gem 'bunny'
gem 'sneakers'

gem 'sass'
gem 'sass-rails', '~> 5.0'

gem 'coffee-rails', '~> 5.0.0'
gem 'uglifier', '>= 1.3.0'

gem 'jbuilder'
gem 'jquery-rails'

gem 'ransack'

gem 'sidekiq', '< 5'

gem 'hiredis'
gem 'redis'
gem 'redis-rails'
gem 'redis-store'

gem 'nokogiri'

gem 'will_paginate', '~> 3.1.0'

gem 'httparty'
gem 'rest-client'

# javascript runtime
gem 'execjs'
gem 'therubyracer'

gem 'net-ssh'

gem 'rucaptcha'

gem 'geokit-rails'

group :development, :test do
  gem 'listen'

  gem 'factory_bot_rails'
  gem 'rspec-its'
  gem 'rspec-rails'

  gem 'rails-controller-testing'

  # Capybara helps you test web applications by simulating how real user interact with your app
  gem 'capybara'

  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'byebug'
  gem 'database_cleaner'
  gem 'faker'
  gem 'letter_opener'
  gem 'meta_request'
  gem 'pry-rails'
  gem 'timecop'

  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'

  # Annotate Rails classes with schema and routes info
  gem 'annotate'
  gem 'brakeman'
  gem 'rack-cors', require: 'rack/cors'
  gem 'redis-rails-instrumentation'
end

group :production do
  gem 'newrelic_rpm'
end

group :test do
  gem 'rspec-sidekiq'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
