worker_processes 1
working_directory Dir.pwd
listen "/web/ktv_staging.sock", :backlog => 64
timeout 30
pid "#{Dir.pwd}/tmp_staging/pids/unicorn.pid"
stderr_path "#{Dir.pwd}/log_staging/unicorn.err.log"
stdout_path "#{Dir.pwd}/log_staging/unicorn.log"
preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

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
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end

  $im_running_under_unicorn = true
end

after_fork do |server, worker|
  redis_connect!(worker.nr)

  Rails.logger = Logger.new("#{Rails.root}/log_staging/#{Rails.env}.#{worker.nr}.log", File::WRONLY | File::APPEND)

  ActiveSupport::LogSubscriber.logger = Rails.logger
  ActionController::Base.logger = Rails.logger
  ActionMailer::Base.logger = Rails.logger
  ActiveResource::Base.logger = Rails.logger

  Ktv.config.logger = Logger.new("#{Rails.root}/log_staging/#{Rails.env}.ktv.#{worker.nr}.log",File::WRONLY|File::APPEND)
  $debug_logger = Logger.new("#{Rails.root}/log_staging/#{Rails.env}.debug.#{worker.nr}.log", File::WRONLY | File::APPEND)
end