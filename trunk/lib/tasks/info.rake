# coding: utf-8
require 'pp'
def ids_emails(ids)
  User.where(:_id.in=>ids).collect(&:email)
end
def user_emails(log)
  ids = log.collect(&:user_id).uniq
  ids_emails(ids)
end
namespace :info do
  task :all=>:environment do
    puts '有关注行为的用户：'
    pp user_emails( Log.where(:action.in=>['FOLLOW_TOPIC','FOLLOW_ASK','UNFOLLOW_ASK','FOLLOW_USER','UNFOLLOW_USER','UNFOLLOW_TOPIC']) )
    puts '有解答行为的用户：'
    pp user_emails(Answer.all)
    puts '投票（赞成、反对）'
    emails = []
    emails += ids_emails(Answer.where(:'votes.up_count'.gt=>0).collect{|x|x.votes['u']}.flatten.compact.uniq)
    emails += ids_emails(Answer.where(:'votes.down_count'.gt=>0).collect{|x|x.votes['u']}.flatten.compact.uniq)
    pp emails.uniq
  end
end