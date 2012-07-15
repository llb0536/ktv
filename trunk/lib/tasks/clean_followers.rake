# coding: utf-8

namespace :clean do
  task :followers=>:environment do
#names=[]
    User.where(:is_expert=>true).any_in(:name=>[ "孙艳姿"]).each{|user|
p "======================================================"
p user.name
p "======================================================"
      #next unless user.follower_ids.count>500
i = 0
user.save!
      user.followers.each{|follower|
i += 1
next if i<47
next unless follower
user.follower_ids.delete follower.id
follower.following_ids.delete user.id
follower.save
user.save if 0==i%1000
      }
user.save
    }
#p names
  end
end
