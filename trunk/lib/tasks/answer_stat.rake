# coding: utf-8
namespace :answer do
  task :stat=>:environment do
	user_ids=Answer.where(:created_at.gt=>5.days.ago).all.collect{|ans| ans.user_id};
	user_uniq_ids=user_ids.uniq;
	us = user_uniq_ids.collect{|u| User.find(u) if user_ids.count(u)>=5}.compact;
	us_res = us.collect{|u| u unless u.email.ends_with?('zhaopin.com.cn')}.compact!;
	#us_res.collect(&:email)
        us_res.each do |x|
	  puts  x.email
        end
  end
end

