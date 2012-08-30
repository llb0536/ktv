#coding: utf-8
require 'spec_helper'

describe Ask do
  it "when being followed/unfollowed, transform its `follower_ids` array" do
    ask = $_asks[0]
    users = $_users[0..2]
    users[0].follow_ask(ask,true)
    ask.follower_ids.should eq([users[0].id])
    # 重复关注也不应该出现冗余条目
    users[0].follow_ask(ask,true)
    ask.follower_ids.should eq([users[0].id])

    users[0].unfollow_ask(ask,true)
    ask.follower_ids.should eq([])

    users.each{|user|user.follow_ask(ask,true)}
    ask.follower_ids.should eq([users[0].id,users[1].id,users[2].id])

    users[1].unfollow_ask(ask,true)
    ask.follower_ids.should eq([users[0].id,users[2].id])

    # 重复反关注也不应该出现删除过量
    users[1].unfollow_ask(ask,true)
    ask.follower_ids.should eq([users[0].id,users[2].id])
  end
  
  it "when update_topics with add, creates an AskLog" do
    user = $_users[3]
    ask = $_asks[1]
    topics = FactoryGirl.create_list(:topic,3)
    ask.update_topics(topics.collect(&:name),true,user.id)
    log = Log.last
    log.user_id.should eq user.id
    log.title.should eq topics.collect(&:name).join(',')
    log.target_id.should eq ask.id
    log.action.should eq 'ADD_TOPIC'
    log.target_parent_id.should eq ask.id
    log.target_parent_title.should eq ask.title
  end
  # it "when created, trigger LogbodyJob" do
  #   ask = FactoryGirl.create(:ask)
  #   job = resque_reserve_latest(:redundancy)
  #   job.payload['class'].should eq 'Askbody2Job'
  #   job.payload['args'].first['ask_id'].should eq ask.id.to_s
  # end

end