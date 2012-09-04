# -*- encoding : utf-8 -*-
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)

RSpec.configure do |config|
  config.before(:suite) do
    Mongoid.purge!
    $redis.flushall
    $redis_search.flushall
    $redis_resque.flushall
    $redis_users.flushall
    $redis_topics.flushall
    $redis_asks.flushall
    $redis_experts.flushall
    Topic.locate('root')
    %w{
      A->root
      B->root
    	C->root
    	ab->A
    	ab->B
    	abc->A
    	abc->B
    	abc->C
    	abA->ab
    	abA->A
    	z->abA
    	z->B
    	zz->z
    	abcd->abc
    	dd->d
    	d->c
    	c->C
    }.each do |line|
      lines = line.split('->')
      t=Topic.locate(lines[0].strip)
      t.fathers << lines[1].strip
      t.save!
    end
    # c.f. test1.dot
  end
end
