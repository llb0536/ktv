worker_processes 2
working_directory Dir.pwd
listen 7000, :tcp_nopush => true
pid "#{Dir.pwd}/tmp/pids/unicorn.pid"
stderr_path "#{Dir.pwd}/log/unicorn.log"
stdout_path "#{Dir.pwd}/log/unicorn.log"
preload_app true

before_fork do |server, worker|
  ##
  # When sent a USR2, Unicorn will suffix its pidfile with .oldbin and
  # immediately start loading up a new version of itself (loaded with a new
  # version of our app). When this new Unicorn is completely loaded
  # it will begin spawning workers. The first worker spawned will check to
  # see if an .oldbin pidfile exists. If so, this means we've just booted up
  # a new Unicorn and need to tell the old one that it can now die. To do so
  # we send it a QUIT.
  #
  # Using this method we get 0 downtime deploys.

  old_pid = "#{Dir.pwd}/tmp/pids/unicorn.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      system("echo 'Quora Unicorn reload failed.'")
      # someone else did our job for us
    end
  end
  $im_running_under_unicorn = true
  
end

after_fork do |server, worker|
  redis_connect!(worker.nr)

  Rails.logger = Logger.new("#{Rails.root}/log/#{Rails.env}.#{worker.nr}.log", File::WRONLY | File::APPEND)

  ActiveSupport::LogSubscriber.logger = Rails.logger
  ActionController::Base.logger = Rails.logger
  ActionMailer::Base.logger = Rails.logger
  ActiveResource::Base.logger = Rails.logger

  Ktv.config.logger = Logger.new("#{Rails.root}/log/#{Rails.env}.ktv.#{worker.nr}.log",File::WRONLY|File::APPEND)
  $debug_logger = Logger.new("#{Rails.root}/log/#{Rails.env}.debug.#{worker.nr}.log", File::WRONLY | File::APPEND)
end