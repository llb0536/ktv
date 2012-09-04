# -*- encoding : utf-8 -*-
require "redis"
require "redis-search"

def redis_connect!(index=0)
  $debug_logger.fatal("redis_connect! at #{index} (#{index.class})")
  redis_config = YAML.load_file("#{Rails.root}/config/redis.yml")[Rails.env]
  select = 0
  $passwd = '87dsFDLKJ7^*$@#_Dn1..d0983DKOI892617jKLKLKDFJ;;dskojifdsouitreo09w'

  $redis = Redis.new(:host => redis_config['host'],:port => redis_config['port'],:thread_safe => true, :password=> $passwd)
  $redis.select(select)
  select+=1

  $redis_search = Redis.new(:host => redis_config['host'],:port => redis_config['port'],:thread_safe => true, :password=> $passwd)
  $redis_search.select(select)
  select+=1

  $redis_resque = Redis.new(:host => redis_config['host'],:port => redis_config['port'],:thread_safe => true, :password=>$passwd) 
  $redis_resque.select(select)
  select+=1

  $redis_users = Redis.new(:host => redis_config['host'],:port => redis_config['port'],:thread_safe => true, :password=>$passwd)
  $redis_users.select(select)
  select+=1

  $redis_topics = Redis.new(:host => redis_config['host'],:port => redis_config['port'],:thread_safe => true, :password=>$passwd)
  $redis_topics.select(select)
  select+=1

  $redis_asks = Redis.new(:host => redis_config['host'],:port => redis_config['port'],:thread_safe => true, :password=>$passwd)
  $redis_asks.select(select)
  select+=1

  $redis_experts = Redis.new(:host => redis_config['host'],:port => redis_config['port'],:thread_safe => true, :password=>$passwd)
  $redis_experts.select(select)
  select+=1

  $redis_courses = Redis.new(:host => redis_config['host'],:port => redis_config['port'],:thread_safe => true, :password=>$passwd)
  $redis_courses.select(select)
  select+=1

  $redis_departments = Redis.new(:host => redis_config['host'],:port => redis_config['port'],:thread_safe => true, :password=>$passwd)
  $redis_departments.select(select)

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


