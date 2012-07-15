task :redis_deleted=>:environment do
  Ask.be_deleted.each do |item|
    item.redis_search_index_destroy
    p $redis_asks.hdel item.id,:title
  end
  Topic.be_deleted.each do |item|
    item.redis_search_index_destroy
    p $redis_topics.hdel item.id,:name
    p $redis_topics.hdel item.id,:summary
    p $redis_topics.hdel item.name,:id
  end
  User.be_deleted.each do |item|
    item.redis_search_index_destroy
    p $redis_users.hdel item.id,:name
    p $redis_users.hdel item.id,:slug
    p $redis_users.hdel item.id,:avatar_filename
    p $redis_experts.hdel item.id,:is_expert_why
  end
end