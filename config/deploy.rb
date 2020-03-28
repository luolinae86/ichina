# frozen_string_literal

require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'
require 'mina/unicorn'
require 'mina_sidekiq/tasks'

set :deploy_to, '/home/deployer/ichina'
set :repository, 'git@github.com:shenbianvip/ichina.git'
set :branch, 'master'
set :shared_paths, ['config/database.yml', 'config/yetting.yml', 'log']

# 设置sidekiq unicorn 的进程保存地址
set :sidekiq_pid, "#{deploy_to}/tmp/pids/sidekiq.pid"
set :unicorn_pid, "#{deploy_to}/tmp/pids/unicorn.pid"

task :environment do
  invoke :'rvm:use[ruby-ruby-2.6.4]'
end

task :setup => :environment do
  # unicorn and sidekiq needs a place to store its pid file
  queue! %[mkdir -p "#{deploy_to}/tmp/sockets/"]
  queue! %[mkdir -p "#{deploy_to}/tmp/pids/"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/database.yml"]
  queue! %[touch "#{deploy_to}/#{shared_path}/config/yetting.yml"]
  queue  %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/database.yml'"]

  queue %[
    repo_host=`echo $repo | sed -e 's/.*@//g' -e 's/:.*//g'` &&
    repo_port=`echo $repo | grep -o ':[0-9]*' | sed -e 's/://g'` &&
    if [ -z "${repo_port}" ]; then repo_port=22; fi ]
end

task :production do
  set :domain, '115.29.241.178'
  set :user, 'deployer'
  set :port, '22'
  set :rvm_path, '/home/deployer/.rvm/bin/rvm'
  set :rails_env, 'production'
  set :unicorn_env, 'production'
end

task :development do
  set :deploy_to, '/home/jd/ichina'
  set :domain, 'china-uk.uk '
  set :user, 'jd'
  set :port, '22'
  set :rvm_path, '/home/ms/.rvm/bin/rvm'
  set :rails_env, 'production'
  set :unicorn_env, 'production'
end

desc 'Deploys the current version to the server.'
task :deploy => :environment do
  to :before_hook do
  end
  deploy do
    #invoke :'sidekiq:quiet'
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      #invoke :'sidekiq:restart'
      invoke :'unicorn:restart'
    end
  end
end
