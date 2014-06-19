require 'capistrano/ext/multistage'
require "rvm/capistrano"
require "bundler/capistrano"
require 'capistrano-unicorn'

set :application, "things"

# Setup RVM
set :rvm_type, :system
set :rvm_ruby_string, 'ruby-2.1.2'

# Setup source control
set :scm, "git"
set :repository, "git@bitbucket.org:ryandunnewold/thing-ninja.git"

set :deploy_via, :remote_cache

set :use_sudo, false
set :user, "apps"
set :ssh_options, { forward_agent: true }

default_run_options[:pty] = true
# Setup stages
set :stages, ["staging", "production"]
set :default_stage, "staging"
set :keep_releases, 2
set :default_environment, {
  'PKG_CONFIG_PATH' => "/usr/local/lib/pkgconfig"
}

set :unicorn_pid, lambda { "/apps/#{application}/shared/pids/unicorn.pid" }

namespace :metova do
  namespace :db do
    desc "Reset the DB"
    task :reset, roles: [:db] do
      run "cd #{current_path} && bundle exec rake db:reset RAILS_ENV=#{rails_env}"
    end
    desc "Drop and recreate the DB"
    task :redo, roles: [:db] do
      run "cd #{current_path}; bundle exec rake db:drop db:create RAILS_ENV=#{rails_env}"
    end
    desc "Load the seed data into the database"
    task :seed, roles: [:db] do
      run "cd #{current_path} && bundle exec rake db:seed RAILS_ENV=#{rails_env}"
    end
    desc "Create the DB"
    task :create, roles: [:db] do
      run "cd #{current_path} && bundle exec rake db:create RAILS_ENV=#{rails_env}"
    end
  end
end

before "deploy:setup", "rvm:create_gemset"
after "deploy:restart", "deploy:cleanup"
after 'deploy:restart', 'unicorn:duplicate'
