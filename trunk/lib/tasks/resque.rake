#require "resque/tasks"
require 'resque/pool/tasks'
task "resque:setup" => :environment do
  # generic worker setup, e.g. Hoptoad for failed jobs
end

# close any sockets or files in pool manager
# and re-open them in the resque worker parent
task "resque:pool:setup" do
  $im_running_under_unicorn = true
  Resque::Pool.after_prefork do |job|
    puts job
    puts job
    puts job
    redis_connect!(job)
  end
end

