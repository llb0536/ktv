#coding: utf-8
require 'spec_helper'

describe Topic do
  it "when created or saved, inform the consultant" do
    topic = FactoryGirl.create(:topic)
    $redis_topics.hget(topic.id,:name).should eq topic.name
    $redis_topics.hget(topic.name,:id).should eq topic.id
    topic.name='jjj'
    topic.save
    $redis_topics.hget(topic.id,:name).should eq 'jjj'
    $redis_topics.hget('jjj',:id).should eq topic.id
  end
  it "when read on class, read from consultant" do
    topic = $_topics[0]
    Topic.get_name(topic.id).should eq topic.name
    Topic.get_id(topic.name).should eq topic.id
    # ensure that get_name indeed uses the cache
    $redis_topics.hset(topic.id,:name,'messed')
    Topic.get_name(topic.id).should eq 'messed'
    # ensure that get_id indeed uses the cache
    $redis_topics.hset('somename',:id,'dfsafdafds')
    Topic.get_id('somename').should eq 'dfsafdafds'
  end
  it "when updated, update the consultant" do
    topic = $_topics[0]
    topic.update_attribute(:name,'changed_name_sa!')
    $redis_topics.hget(topic.id,:name).should eq 'changed_name_sa!'
    $redis_topics.hget('changed_name_sa!',:id).should eq topic.id
  end
  
  it "when being followed/unfollowed, transform its `follower_ids` array" do
    users = $_users[0..2]
    topic = $_topics[0]
    users[0].follow_topic(topic,true)
    topic.follower_ids.should eq([users[0].id])
    # 重复关注也不应该出现冗余条目
    users[0].follow_topic(topic,true)
    topic.follower_ids.should eq([users[0].id])
    
    users[0].unfollow_topic(topic,true)
    topic.follower_ids.should eq([])

    users.each{|user|user.follow_topic(topic,true)}
    topic.follower_ids.should eq([users[0].id,users[1].id,users[2].id])

    users[1].unfollow_topic(topic,true)
    topic.follower_ids.should eq([users[0].id,users[2].id])

    # 重复反关注也不应该出现删除过量
    users[1].unfollow_topic(topic,true)
    topic.follower_ids.should eq([users[0].id,users[2].id])
  end
end