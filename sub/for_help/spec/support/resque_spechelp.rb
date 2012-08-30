def resque_reserve_latest(queue)
  return unless payload = JSON.parse(Resque.redis.rpop("queue:#{queue}"))
  Resque::Job.new(queue, payload)
end