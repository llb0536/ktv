# coding: utf-8
def print_user(f,user,hash=nil)
  zancnt = 0
  user.answers.each do |ans|
    zancnt += Log.where(action:"AGREE").where(target_id:ans.id).count
  end

  bgxcnt = 0
  user.answers.each do |ans|
    bgxcnt += Log.where(action:"THANK_ANSWER").where(target_id:ans.id).count
  end
  if !hash
    # 用户ID
    f.print(user.email)
    f.print(',')
    # 提问数
    f.print(user.asks.count)
    f.print(',')
    # 解答数
    f.print(user.answers.count)
    f.print(',')
    # 评论数
    f.print(Comment.where(user_id:user.id).count)
    f.print(',')
    # 被赞次数

    f.print(zancnt)
    f.print(',')
    # 赞别人的次数
    f.print(Log.where(action:"AGREE").where(user_id:user.id).count)
    f.print(',')
    # 被感谢次数

    f.print(bgxcnt)
    f.print(',')
    # 感谢别人的次数
    f.print(Log.where(action:"THANK_ANSWER").where(user_id:user.id).count)
    f.print(',')
    # 关注数
    f.print(Log.where(action:"FOLLOW_USER").where(user_id:user.id).count)
    f.print(',')
    # 被关注数
    f.print(Log.where(action:"FOLLOW_USER").where(target_id:user.id).count)
    f.print(',')
    # 邀请别人解答次数
    f.print(Log.where(action:'INVITE_TO_ANSWER').where(user_id:user.id).count)
    f.print(',')
    # 被邀请次数
    f.print(Log.where(action:'INVITE_TO_ANSWER').where(target_id:user.id).count)
    f.print(',')
    f.print("\n")
  else
    hash['提问数'] += user.asks.count
    hash['解答数'] += user.answers.count
    hash['评论数'] += Comment.where(user_id:user.id).count
    hash['被赞次数'] += zancnt
    hash['赞别人的次数'] += Log.where(action:"AGREE").where(user_id:user.id).count
    hash['被感谢次数'] += bgxcnt
    hash['感谢别人的次数'] += Log.where(action:"THANK_ANSWER").where(user_id:user.id).count
    hash['关注数'] += Log.where(action:"FOLLOW_USER").where(user_id:user.id).count
    hash['被关注数'] += Log.where(action:"FOLLOW_USER").where(target_id:user.id).count
    hash['邀请别人解答次数'] += Log.where(action:'INVITE_TO_ANSWER').where(user_id:user.id).count
    hash['被邀请次数'] += Log.where(action:'INVITE_TO_ANSWER').where(target_id:user.id).count
  end
end

def report!(ago,today)
  File.open("#{Rails.root}/auxiliary/stat_#{ago.strftime("%Y%m%d")}_to_#{today.strftime("%Y%m%d")}.csv","w") do |f|
    f.puts('项目名称,数据数值')
    hash = Hash.new(0)
    User.desc('created_at').each_with_index do |user,index|
      print_user(f,user,hash)
    end
    hash.each do |key,value|
      f.print("#{key},#{value}\n")
    end
  end
end


namespace :stat do
  
  task :csv=>:environment do
    File.open("#{Rails.root}/auxiliary/stat.csv","w") do |f|
      f.puts('编号,用户ID,提问数,解答数,评论数,被赞次数,赞别人的次数,被感谢次数,感谢别人的次数,关注数,被关注数,邀请别人解答次数,被邀请次数')
      User.desc('created_at').each_with_index do |user,index|
        # 编号
        f.print(index)
        f.print(',')
        print_user(f,user)
      end
    end
  end
    
  task :monthly=>:environment do
    report!(Time.now,1.months.ago)
  end
  
  task :weekly=>:environment do
    report!(Time.now,1.weeks.ago)
  end
  
  
end