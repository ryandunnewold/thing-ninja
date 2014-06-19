rails_env = ENV['RAILS_ENV'] || 'production'
appname = "things" #Rails.application.class.parent_name.downcase
# Set your full path to application.
app_path = "/apps/#{appname}/current"
app_shared_path = "/apps/#{appname}/shared"
# Spawn unicorn master worker for user apps (group: apps)
user 'apps'
# Sample verbose configuration file for Unicorn (not Rack)
#
# This configuration file documents many features of Unicorn
# that may not be needed for some applications. See
# http://unicorn.bogomips.org/examples/unicorn.conf.minimal.rb
# for a much simpler configuration file.
#
# See http://unicorn.bogomips.org/Unicorn/Configurator.html for complete
# documentation.
# Use at least one worker per core if you're on a dedicated server,
# more will usually help for _short_ waits on databases/caches.

# if rails_env == 'production'
#   worker_processes 2
# else
#   worker_processes 1
# end

worker_processes 1

# Since Unicorn is never exposed to outside clients, it does not need to
# run on the standard HTTP port (80), there is no reason to start Unicorn
# as root unless it's from system init scripts.
# If running the master process as root and the workers as an unprivileged
# user, do this to switch euid/egid in the workers (also chowns logs):
# user "unprivileged_user", "unprivileged_group"
# Help ensure your application will always spawn in the symlinked
# "current" directory that Capistrano sets up.
working_directory app_path # available in 0.94.0+
# listen on both a Unix domain socket and a TCP port,
# we use a shorter backlog for quicker failover when busy
listen "#{app_shared_path}/pids/unicorn.sock", :backlog => 64
listen 8080, :tcp_nopush => true
timeout 60
# feel free to point this anywhere accessible on the filesystem
pid "#{app_shared_path}/pids/unicorn.pid"
p "#{app_shared_path}/pids/unicorn.pid"
# By default, the Unicorn logger will write to stderr.
# Additionally, ome applications/frameworks log to stderr or stdout,
# so prevent them from going to /dev/null when daemonized here:
stderr_path "#{app_shared_path}/log/unicorn.stderr.log"
stdout_path "#{app_shared_path}/log/unicorn.stdout.log"
# combine Ruby 2.0.0dev or REE with "preload_app true" for memory savings
# http://rubyenterpriseedition.com/faq.html#adapt_apps_for_cow
preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
    GC.copy_on_write_friendly = true
# Enable this flag to have unicorn test client connections by writing the
# beginning of the HTTP headers before calling the application.  This
# prevents calling the application for connections that have disconnected
# while queued.  This is only guaranteed to detect clients on the same
# host unicorn runs on, and unlikely to detect disconnects even on a
# fast LAN.
check_client_connection false
before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect!
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end
 
after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end