require "redis"
require "redis-search"

def redis_connect!(index=0)
  $debug_logger.fatal("redis_connect! at #{index} (#{index.class})")

  redis_config = YAML.load_file("#{Rails.root}/config/redis.yml")[Rails.env]
  $redis = Redis.new(:host => redis_config['host'],:port => redis_config['port'],:thread_safe => true, :password=>'87dsFDLKJ7^*$@#_Dn1..d0983DKOI892617jKLKLKDFJ;;dskojifdsouitreo09w')
  $redis.select(redis_config['select'])

  $redis_search = Redis.new(:host => redis_config['host_search'],:port => redis_config['port_search'],:thread_safe => true, :password=>'87dsFDLKJ7^*$@#_Dn1..d0983DKOI892617jKLKLKDFJ;;dskojifdsouitreo09w')
  $redis_search.select(redis_config['select_search'])

  $redis_resque = Redis.new(:host => redis_config['host_resque'],:port => redis_config['port_resque'],:thread_safe => true, :password=>'87dsFDLKJ7^*$@#_Dn1..d0983DKOI892617jKLKLKDFJ;;dskojifdsouitreo09w') 
  $redis_resque.select(redis_config['select_resque'])

  $redis_users = Redis.new(:host => redis_config['host_users'],:port => redis_config['port_users'],:thread_safe => true, :password=>'87dsFDLKJ7^*$@#_Dn1..d0983DKOI892617jKLKLKDFJ;;dskojifdsouitreo09w')
  $redis_users.select(redis_config['select_users'])

  $redis_topics = Redis.new(:host => redis_config['host_topics'],:port => redis_config['port_topics'],:thread_safe => true, :password=>'87dsFDLKJ7^*$@#_Dn1..d0983DKOI892617jKLKLKDFJ;;dskojifdsouitreo09w')
  $redis_topics.select(redis_config['select_topics'])

  $redis_asks = Redis.new(:host => redis_config['host_asks'],:port => redis_config['port_asks'],:thread_safe => true, :password=>'87dsFDLKJ7^*$@#_Dn1..d0983DKOI892617jKLKLKDFJ;;dskojifdsouitreo09w')
  $redis_asks.select(redis_config['select_asks'])

  $redis_experts = Redis.new(:host => redis_config['host_experts'],:port => redis_config['port_experts'],:thread_safe => true, :password=>'87dsFDLKJ7^*$@#_Dn1..d0983DKOI892617jKLKLKDFJ;;dskojifdsouitreo09w')
  $redis_experts.select(redis_config['select_experts'])

  Redis::Search.configure do |config|
    config.redis = $redis_search
    config.complete_max_length = 100
    config.pinyin_match = true
    config.disable_rmmseg = false
  end

  # Resque
  Resque.redis = $redis_resque
  
  
  $snda_service = Sndacs::Service.new(:access_key_id => Setting.snda_id, :secret_access_key => Setting.snda_key)
  $snda_buckets = $snda_service.buckets
  $snda_ktv_eb = $snda_buckets.find("ktv-eb")
  $snda_ktv_down = $snda_buckets.find("ktv-down")
  $snda_ktv_up = $snda_buckets.find("ktv-up")
end



redis_connect! unless $im_running_under_unicorn


