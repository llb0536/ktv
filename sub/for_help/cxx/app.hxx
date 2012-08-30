#pragma once
class App : private boost::noncopyable{
  redisContext *redis;
  redisContext *redis_search;
  redisContext *redis_resque;
  redisContext *redis_users;
  redisContext *redis_topics;
  redisContext *redis_asks;
  redisContext *redis_experts;
  DBClientConnection c;
  int number;
  int numbers;
public:
  App(int param_number,int param_numbers);
  void start();
  void topicsSuggest();
  void topicobj_topics(const BSONObj &topic,vector<string> &topics);
};
