#coding: utf-8
require 'spec_helper'

describe User do
  it "when created or saved, inform the consultant" do
    user = FactoryGirl.build(:user)
    $redis_users.hget(user.id,:name).should eq nil
    user.save!
    user.update_consultant!
    $redis_users.hget(user.id,:name).should eq user.name
    $redis_users.hget(user.id,:slug).should eq user.slug
    $redis_users.hget(user.id,:avatar_filename).should eq user.avatar_filename
    user.name='jjj'
    user.save!
    user.update_consultant!
    $redis_users.hget(user.id,:name).should eq 'jjj'
  end
  it "when read on class, read from consultant" do
    user = $_users[0]
    User.get_name(user.id).should eq user.name
    User.get_slug(user.id).should eq user.slug
    User.get_avatar_filename(user.id).should eq user.avatar_filename
    $redis_users.hset(user.id,:name,'messed1')
    $redis_users.hset(user.id,:slug,'messed2')
    $redis_users.hset(user.id,:avatar_filename,'messed3')
    User.get_name(user.id).should eq 'messed1'
    User.get_slug(user.id).should eq 'messed2'
    User.get_avatar_filename(user.id).should eq 'messed3'
  end
  it "when updated, update the consultant" do
    user=$_users[1]
    user.update_attribute(:name,'changed_name_sa!')
    user.update_attribute(:slug,'changedslug')
    user.update_consultant!
    $redis_users.hget(user.id,:name).should eq 'changed_name_sa!'
    $redis_users.hget(user.id,:slug).should eq 'changedslug'
  end
  it "when expert, handle is_expert_why with the consultant" do
    user = FactoryGirl.build(:expert)
    $redis_experts.hget(user.id,:is_expert_why).should eq nil
    user.save!
    user.update_consultant!
    $redis_experts.hget(user.id,:is_expert_why).should eq user.is_expert_why
    user.update_attribute(:is_expert_why,'changed_expert_desc')
    user.update_consultant!
    $redis_experts.hget(user.id,:is_expert_why).should eq 'changed_expert_desc'
    User.get_is_expert_why(user.id).should eq 'changed_expert_desc'
  end
  
  it "when follow/unfollow topics, transform its `followed_topic_ids` arrays" do
    user = $_users[0]
    topics = $_topics[0..2]
    user.follow_topic(topics[0],true)
    user.followed_topic_ids.should eq([topics[0].id])
    # 重复关注也不应该出现冗余条目
    user.follow_topic(topics[0],true)
    user.followed_topic_ids.should eq([topics[0].id])
    
    user.unfollow_topic(topics[0],true)
    user.followed_topic_ids.should eq([])

    user.follow_topics(topics,true)
    user.followed_topic_ids.should eq([topics[0].id,topics[1].id,topics[2].id])

    user.unfollow_topic(topics[1],true)
    user.followed_topic_ids.should eq([topics[0].id,topics[2].id])

    # 重复反关注也不应该出现删除过量
    user.unfollow_topic(topics[1],true)
    user.followed_topic_ids.should eq([topics[0].id,topics[2].id])
  end

  it "when follow/unfollow asks, transform its `followed_ask_ids` arrays" do
    user = $_users[10]
    asks = $_asks[2..4]
    user.follow_ask(asks[0],true)
    user.followed_ask_ids.should eq([asks[0].id])
    # 重复关注也不应该出现冗余条目
    user.follow_ask(asks[0],true)
    user.followed_ask_ids.should eq([asks[0].id])

    user.unfollow_ask(asks[0],true)
    user.followed_ask_ids.should eq([])

    user.follow_asks(asks,true)
    user.followed_ask_ids.should eq([asks[0].id,asks[1].id,asks[2].id])

    user.unfollow_ask(asks[1],true)
    user.followed_ask_ids.should eq([asks[0].id,asks[2].id])

    # 重复反关注也不应该出现删除过量
    user.unfollow_ask(asks[1],true)
    user.followed_ask_ids.should eq([asks[0].id,asks[2].id])
  end

  
  it "when follow/unfollow other user, transform its `following_ids` arrays" do
    user = $_users[3]
    users = $_users[4..6]

    user.follow(users[0],true)
    user.following_ids.should eq([users[0].id])
    # 重复关注也不应该出现冗余条目
    user.follow(users[0],true)
    user.following_ids.should eq([users[0].id])

    user.unfollow(users[0],true)
    user.following_ids.should eq([])

    user.follow(users,true)
    user.following_ids.should eq([users[0].id,users[1].id,users[2].id])

    user.unfollow(users[1],true)
    user.following_ids.should eq([users[0].id,users[2].id])

    # 重复反关注也不应该出现删除过量
    user.unfollow(users[1],true)
    user.following_ids.should eq([users[0].id,users[2].id])
  end
  
  it "when being followed/unfollowed by other users, transform its `follower_ids` array" do
    user = $_users[7]
    users = $_users[8..10]
    
    users[0].follow(user,true)
    user.follower_ids.should eq([users[0].id])
    # 重复关注也不应该出现冗余条目
    users[0].follow(user,true)
    user.follower_ids.should eq([users[0].id])

    users[0].unfollow(user,true)
    user.follower_ids.should eq([])

    users.each{|u|u.follow(user,true)}
    user.follower_ids.should eq([users[0].id,users[1].id,users[2].id])

    users[1].unfollow(user,true)
    user.follower_ids.should eq([users[0].id,users[2].id])

    # 重复反关注也不应该出现删除过量
    users[1].unfollow(user,true)
    user.follower_ids.should eq([users[0].id,users[2].id])
  end
  
  # it "when update name, update his/her answered and asked asks" do
  #   user = $_users[8]
  #   asks = FactoryGirl.create_list(:ask,3,:user=>user)
  # 
  #   answers = FactoryGirl.create_list(:answer,2,:ask_id=>$_asks.first.id,:user_id=>user.id)
  #   answers << FactoryGirl.create_list(:answer,2,:ask_id=>$_asks.last.id,:user_id=>user.id)
  #   
  #   jobs = []
  #   3.times{jobs<<resque_reserve_latest(:redundancy)}
  #   classes = jobs.collect{|item| item.payload['class']}
  #   args = jobs.collect{|item| item.payload['args']}
  #   
  #   classes.should include('LogbodyJob')
  #   classes.should include('Askbody2Job')
  #   answer_related_asks = []
  #   user.answers.each do |item|
  #     args.should include(item.id.to_s)
  #     answer_related_asks << item.ask
  #   end
  #   (user.asks+answer_related_asks).each do |item|
  #     args.should include(item.id.to_s)
  #   end
  # end
  
  
end
