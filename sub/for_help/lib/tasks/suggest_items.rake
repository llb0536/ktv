require 'benchmark'
namespace :suggest do


  task :ask_asks => :environment do
    AskSuggestAsk.delete_all
    Ask.nondeleted.where(:topics.ne=>[]).each do |ask|
      AskSuggestAsk.find_by_ask(ask,:force => true, :debug => true)
    end
  end
  
  task :ed_ask_asks => :environment do
    Ask.nondeleted.where(:updated_at.gt=>(Time.now-1.day),:topics.ne=>[]).each do |ask|
      AskSuggestAsk.find_by_ask(ask,:force => true, :debug => true)
    end
  end

  task :topic_topics => :environment do
    puts Benchmark.measure{
      TopicSuggestTopic.delete_all
      Topic.nondeleted.each do |topic|
        TopicSuggestTopic.find_by_topic(topic,:force => true, :debug => true)
      end      
    }
  end


  task :topic_experts => :environment do
    TopicSuggestExpert.delete_all
    expert_topics = TopicSuggestExpert.calculate_expert_topics
    expert_topics.each do |key,value|
      puts "#{User.find(key).name}: #{value}"
    end
    Topic.nondeleted.each do |topic|
      TopicSuggestExpert.find_by_topic(topic,:force => true, :expert_topics=>expert_topics, :debug => true)
    end
  end
  
  task :user => :environment do
    UserSuggestItem.delete_all
    puts "Make sure that you execute this as the last step..."
    User.nondeleted.each do |user|
      UserSuggestItem.find_by_user(user,:force => true,:debug => true)
    end
  end


end
