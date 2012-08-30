# coding: utf-8
namespace :answer do
  task :stat=>:environment do
    user_ids=Answer.where(:created_at.gt=>5.days.ago).all.collect{|ans| ans.user_id};
    user_uniq_ids=user_ids.uniq;
    us = user_uniq_ids.collect{|u| User.find(u) if user_ids.count(u)>=5}.compact;
    us_res = us.collect{|u| u unless u.email.ends_with?('kejian.tv')}.compact!;
    #us_res.collect(&:email)
    us_res.each do |x|
      puts  x.email
    end
  end
  task :emails=>:environment do
    user_ids=Answer.where(:created_at.gt=>"2012-07-01",:created_at.lt=>"2012-08-01").map{|x|x.user_id}.uniq
    users=User.where(:_id.in=>user_ids).map{|x|x.email}.compact
    File.open("#{Rails.root}/auxiliary/answer.txt","w") do |f|
      users.each do |u|
        f.puts u
      end
    end
    
    user_ids=Ask.where(:created_at.gt=>"2012-07-01",:created_at.lt=>"2012-08-01").map{|x|x.user_id}.uniq
    users=User.where(:_id.in=>user_ids).map{|x|x.email}.compact
    File.open("#{Rails.root}/auxiliary/ask.txt","w") do |f|
      users.each do |u|
        f.puts u
      end
    end
  end
end

