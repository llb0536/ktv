require "redis"
require "redis-search"

def redis_connect!

  redis_config = YAML.load_file("#{Rails.root}/config/redis.yml")[Rails.env]
  $redis = Redis.new(:host => redis_config['host'],:port => redis_config['port'],:thread_safe => true)
  $redis.select(redis_config['select'])

  $redis_search = Redis.new(:host => redis_config['host_search'],:port => redis_config['port_search'],:thread_safe => true)
  $redis_search.select(redis_config['select_search'])
  $redis_search_slave = Redis.new(:host => redis_config['host_search_slave'],:port => redis_config['port_search_slave'],:thread_safe => true)
  $redis_search_slave.select(redis_config['select_search_slave'])

  $redis_resque = Redis.new(:host => redis_config['host_resque'],:port => redis_config['port_resque'],:thread_safe => true) 
  $redis_resque.select(redis_config['select_resque'])

  $redis_users = Redis.new(:host => redis_config['host_users'],:port => redis_config['port_users'],:thread_safe => true)
  $redis_users.select(redis_config['select_users'])

  $redis_topics = Redis.new(:host => redis_config['host_topics'],:port => redis_config['port_topics'],:thread_safe => true)
  $redis_topics.select(redis_config['select_topics'])

  $redis_asks = Redis.new(:host => redis_config['host_asks'],:port => redis_config['port_asks'],:thread_safe => true)
  $redis_asks.select(redis_config['select_asks'])

  $redis_experts = Redis.new(:host => redis_config['host_experts'],:port => redis_config['port_experts'],:thread_safe => true)
  $redis_experts.select(redis_config['select_experts'])

  Redis::Search.configure do |config|
    config.redis = $redis_search
    config.redis_slave = $redis_search_slave
    config.complete_max_length = 100
    config.pinyin_match = true
  end

  # Resque
  Resque.redis = $redis_resque

end



redis_connect! unless $im_running_under_unicorn


