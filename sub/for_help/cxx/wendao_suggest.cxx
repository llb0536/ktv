#include "wendao.hxx"
#include <cassert>

typedef std::map<string, int> ret_t;
bool ret_keys_sorter(const string &k1, const string &k2, ret_t& ret) {
  return ret[k1] > ret[k2];
}

void WendaoSuggest::topicobj_topics(const BSONObj &topic,vector<string> &topics){

  vector<be> follower_ids = topic["follower_ids"].Array();

  ret_t ret;
  BOOST_FOREACH(const BSONElement &id,follower_ids){
    BSONObj user = _c.findOne(DB_NAME+".users", BSON("_id"<<id));
    BOOST_FOREACH(const BSONElement &tid,user["followed_topic_ids"].Array()){
      string tids = tid.OID().toString();
      if(ret.find(tids)==ret.end()){
        ret[tids]=1;        
      }else{
        ret[tids]+=1;
      }
    }
  }
  vector<string> ret_keys;
  BOOST_FOREACH(const ret_t::value_type &i,ret){
    ret_keys.push_back(i.first);
  }
  sort(ret_keys.begin(),ret_keys.end(),boost::bind(&ret_keys_sorter,_1,_2,ret));
  remove_if(ret_keys.begin(),ret_keys.end(),boost::lambda::_1==topic["_id"].OID().toString());
  // Output now
  BOOST_FOREACH(string &k,ret_keys){
    BSONObj t = _c.findOne(DB_NAME+".topics", BSONObjBuilder().append("_id",OID(k)).obj());
    if(t.isEmpty()) continue;
    string name = t.getStringField("name");
    cout << name << "("<< ret[k] << ") ";
    topics.push_back(name);
  }
  cout << endl;
}