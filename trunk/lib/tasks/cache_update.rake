namespace :update do
  task :cache => :environment do
    #    def global_topic_calculations
    #      $topics = Topic.nondeleted.to_a.collect{|x|[x.name,x.followers_count,Log.where(action:'ADD_TOPIC').where(:created_at.gt=>150.days.ago).where(title:x.name).count]}.sort{|x,y|
    #        result = x[1]<=>y[1]
    #        if 0==result
    #          result = x[2]<=>y[2]
    #        end
    #        result
    #      }.reverse
    #    end
    #global_topic_calculations
    $topics = Topic.nondeleted.where(:asks_count.gt=>SettingItem.find_or_create_by(:key=>"hot_topics_asks_count").value.to_i,:followed_count.gt=>SettingItem.find_or_create_by(:key=>"hot_topics_followers_count").value.to_i).to_a.collect{|x| [x.name,x.followers_count,(last_ask=AskLog.where(:action=>'ADD_TOPIC').where(:title=>x.name).last).blank? ? 0 : last_ask.created_at,(last_follow=UserLog.where(:action=>'FOLLOW_TOPIC').where(:target_parent_title=>x.name).last).blank? ? 0 : last_follow.created_at]}
    if SettingItem.find_or_create_by(:key=>"hot_topics_sort_by").value.to_s=="last_followed_at"
      $topics =$topics.sort{|x,y|y[3].to_i<=>x[3].to_i}
    else
      $topics =$topics.sort{|x,y|y[2].to_i<=>x[2].to_i}
    end
    #AnswerLog.where(action:'NEW').where(:created_at.gt=>150.days.ago).where(target_parent_id:x.id).count

    $asks = Ask.normal.nondeleted.where(:created_at.gt=>SettingItem.find_or_create_by(:key=>"hot_asks_created_at").value.to_i.days.ago,:answers_count.gte=>SettingItem.find_or_create_by(:key=>"hot_asks_answers_count").value.to_i).to_a.collect{|x| [x,x.last_answer.blank? ? 0 : x.last_answer.created_at]}
    if SettingItem.find_or_create_by(:key=>"hot_asks_sort_by").value.to_s=="answers_count"
      $asks =$asks.sort{|x,y|y[0].answers_count.to_i<=>x[0].answers_count.to_i}
    else
      $asks =$asks.sort{|x,y|y[1].to_i<=>x[1].to_i}
    end
    
    # TopicCache.delete_all
    Mongoid.database.collection('topic_caches').drop
    $topics.each_with_index do |topic,i|
      TopicCache.create!(name:topic[0],hot_rank:i,followers_count:topic[1])
    end

    # AskCache.delete_all
    Mongoid.database.collection('ask_caches').drop
    $asks.each_with_index do |a,i|
      ask=a[0]
      AskCache.create!(ask_id:ask.id,hot_rank:i)
    end 
    
    # ExpertCache.delete_all
    Mongoid.database.collection('expert_caches').drop
    User.where(:is_expert=>true).collect(&:tags).flatten.uniq.each do |tag|
      ec = ExpertCache.create!(tag:tag)
      @ask_ids = Ask.where(:topics => tag).normal.collect(&:id)
      ec.experts = User.where(:is_expert=>true).where(:tags=>tag).to_a.sort{|x,y| x.answers.any_in(:ask_id=>@ask_ids).count <=> y.answers.any_in(:ask_id=>@ask_ids).count}.reverse.collect(&:id)
      ec.save!
    end
  end
  task :ask_cache => :environment do
    $asks = Ask.normal.nondeleted.where(:created_at.gt=>SettingItem.find_or_create_by(:key=>"hot_asks_created_at").value.to_i.days.ago,:answers_count.gte=>SettingItem.find_or_create_by(:key=>"hot_asks_answers_count").value.to_i).to_a.collect{|x| [x,x.last_answer.blank? ? 0 : x.last_answer.created_at]}
    if SettingItem.find_or_create_by(:key=>"hot_asks_sort_by").value.to_s=="answers_count"
      $asks =$asks.sort{|x,y|y[0].answers_count.to_i<=>x[0].answers_count.to_i}
    else
      $asks =$asks.sort{|x,y|y[1].to_i<=>x[1].to_i}
    end
  
    # AskCache.delete_all
    Mongoid.database.collection('ask_caches').drop
    $asks.each_with_index do |a,i|
      ask=a[0]
      AskCache.create!(ask_id:ask.id,hot_rank:i)
    end
  end
  task :topic_cache => :environment do
    $topics = Topic.nondeleted.where(:asks_count.gt=>SettingItem.find_or_create_by(:key=>"hot_topics_asks_count").value.to_i,:followed_count.gt=>SettingItem.find_or_create_by(:key=>"hot_topics_followers_count").value.to_i).to_a.collect{|x| [x.name,x.followers_count,(last_ask=AskLog.where(:action=>'ADD_TOPIC').where(:title=>x.name).last).blank? ? 0 : last_ask.created_at,(last_follow=UserLog.where(:action=>'FOLLOW_TOPIC').where(:target_parent_title=>x.name).last).blank? ? 0 : last_follow.created_at]}
    if SettingItem.find_or_create_by(:key=>"hot_topics_sort_by").value.to_s=="last_followed_at"
      $topics =$topics.sort{|x,y|y[3].to_i<=>x[3].to_i}
    else
      $topics =$topics.sort{|x,y|y[2].to_i<=>x[2].to_i}
    end

    # TopicCache.delete_all
    Mongoid.database.collection('topic_caches').drop
    $topics.each_with_index do |topic,i|
      TopicCache.create!(name:topic[0],hot_rank:i,followers_count:topic[1])
    end
  end
  task :expert_cache => :environment do
    # ExpertCache.delete_all
    Mongoid.database.collection('expert_caches').drop
    User.where(:is_expert=>true).collect(&:tags).flatten.uniq.each do |tag|
      ec = ExpertCache.create!(tag:tag)
      @ask_ids = Ask.where(:topics => tag).normal.collect(&:id)
      ec.experts = User.where(:is_expert=>true).where(:tags=>tag).to_a.sort{|x,y| x.answers.any_in(:ask_id=>@ask_ids).count <=> y.answers.any_in(:ask_id=>@ask_ids).count}.reverse.collect(&:id)
      ec.save!
    end
  end
  task :user_cache => :environment do
    Mongoid.database.collection('user_caches').drop
    User.where('coursewares_count > 8').desc('coursewares_count').limit(100).each_with_index do |item,i|
      ec = UserCache.create!(name:item.name,hot_rank:i,followers_count:item.followers_count)
    end
  end


end
