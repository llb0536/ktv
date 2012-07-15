# coding: utf-8

def pp arr
  arr.each do |item|
    puts item
  end
end

def ids_emails(ids)
  User.where(:_id.in=>ids).collect(&:email)
end

def user_emails(log)
  ids = log.collect(&:user_id).uniq
  ids_emails(ids)
end
namespace :collect do
  task :userbehavior=>:environment do
    puts '有关注行为的用户：'
    pp user_emails( Log.where(:action.in=>['FOLLOW_TOPIC','FOLLOW_ASK','UNFOLLOW_ASK','FOLLOW_USER','UNFOLLOW_USER','UNFOLLOW_TOPIC']) )
    puts '有回答行为的用户：'
    pp user_emails(Answer.all)
    puts '投票（赞成、反对）'
    emails = []
    emails += ids_emails(Answer.where(:'votes.up_count'.gt=>0).collect{|x|x.votes['u']}.flatten.compact.uniq)
    emails += ids_emails(Answer.where(:'votes.down_count'.gt=>0).collect{|x|x.votes['u']}.flatten.compact.uniq)
    pp emails.uniq
  end
end

