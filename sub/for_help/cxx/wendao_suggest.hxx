#pragma once
class WendaoSuggest{
  DBClientConnection& _c;
public:
  WendaoSuggest(DBClientConnection& c):_c(c){}
  void topicobj_topics(const BSONObj &topic,vector<string> &topics);
};
