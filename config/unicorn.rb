# frozen_string_literal: true

module Rails
  class << self
    def root
      File.expand_path('..', __dir__)
    end
  end
end

APP_HOME = Rails.root
working_directory APP_HOME

worker_processes 2

pid "#{APP_HOME}/tmp/pids/unicorn.pid"

if ENV['RAILS_ENV'] == 'production'
  listen '/home/deployer/ichina/tmp/sockets/unicorn.sock', backlog: 64
  # pid '/home/deployer/ichina/tmp/pids/unicorn.pid'
  pid '/home/ms/ichina/tmp/pids/unicorn.pid'
else
  listen 3001, tcp_nopush: true
end

timeout 60

stderr_path "#{APP_HOME}/log/unicorn.stderr.log"
stdout_path "#{APP_HOME}/log/unicorn.stdout.log"

preload_app true

check_client_connection false

before_fork do |server, _worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection.disconnect!

  old_pid = "#{APP_HOME}/tmp/pids/unicorn.pid.oldbin"
  if File.exist?(old_pid) && server.pid != old_pid
    begin
      Process.kill('QUIT', File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      puts "Send 'QUIT' signal to unicorn error!"
    end
  end
end

after_fork do |_server, _worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.establish_connection
end

# fix hot restart Gemfile
before_exec do |_server|
  ENV['BUNDLE_GEMFILE'] = "#{APP_HOME}/Gemfile"
end
