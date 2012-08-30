#include "wendao.hxx"
#include <cassert>


void App::topicsSuggest(){
  // clean up old data
  c.remove(DB_NAME+".topic_suggest_topics" , BSONObj() );
  auto_ptr<DBClientCursor> cursor = c.query(DB_NAME+".topics", BSONObj());
  int i = 0;
  while( cursor->more() ){
    i += 1;
    BSONObj item = cursor->next();
    string topic = item.getStringField("name");
    cout << topic << ':' << endl;
    vector<string> topics;
    topicobj_topics(item,topics);
    BSONObj p =
      BSONObjBuilder().genOID().append("topic_id",item["_id"]).append("sizze",(unsigned int)topics.size()).append("topics",topics).obj();
    c.insert(DB_NAME+".topic_suggest_topics", p);
  }
}

App::App(int param_number,int param_numbers):number(param_number),numbers(param_numbers){
  try{
    #ifdef PSVRDEBUG
    cout << "Connectiong Redis " << redis_yml->configs[environment].config["host"].c_str() << " " << AtoI(redis_yml->configs[environment].config["port"]) << (" SELECT "+redis_yml->configs[environment].config["select"]) << endl;
    cout << "Connectiong Redis " << redis_yml->configs[environment].config["host_search"].c_str() << " " << AtoI(redis_yml->configs[environment].config["port_search"]) << (" SELECT "+redis_yml->configs[environment].config["select_search"]) << endl;
    cout << "Connectiong Redis " << redis_yml->configs[environment].config["host_resque"].c_str() << " " << AtoI(redis_yml->configs[environment].config["port_resque"]) << (" SELECT "+redis_yml->configs[environment].config["select_resque"]) << endl;
    cout << "Connectiong Redis " << redis_yml->configs[environment].config["host_users"].c_str() << " " << AtoI(redis_yml->configs[environment].config["port_users"]) << (" SELECT "+redis_yml->configs[environment].config["select_users"]) << endl;
    cout << "Connectiong Redis " << redis_yml->configs[environment].config["host_topics"].c_str() << " " << AtoI(redis_yml->configs[environment].config["port_topics"]) << (" SELECT "+redis_yml->configs[environment].config["select_topics"]) << endl;
    cout << "Connectiong Redis " << redis_yml->configs[environment].config["host_asks"].c_str() << " " << AtoI(redis_yml->configs[environment].config["port_asks"]) << (" SELECT "+redis_yml->configs[environment].config["select_asks"]) << endl;
    cout << "Connectiong Redis " << redis_yml->configs[environment].config["host_experts"].c_str() << " " << AtoI(redis_yml->configs[environment].config["port_experts"]) << (" SELECT "+redis_yml->configs[environment].config["select_experts"]) << endl;
    #endif
    
    redis = redisConnect(redis_yml->configs[environment].config["host"].c_str(), AtoI(redis_yml->configs[environment].config["port"]));
    redis_search = redisConnect(redis_yml->configs[environment].config["host_search"].c_str(), AtoI(redis_yml->configs[environment].config["port_search"]));
    redis_resque = redisConnect(redis_yml->configs[environment].config["host_resque"].c_str(), AtoI(redis_yml->configs[environment].config["port_resque"]));
    redis_users = redisConnect(redis_yml->configs[environment].config["host_users"].c_str(), AtoI(redis_yml->configs[environment].config["port_users"]));
    redis_topics = redisConnect(redis_yml->configs[environment].config["host_topics"].c_str(), AtoI(redis_yml->configs[environment].config["port_topics"]));
    redis_asks = redisConnect(redis_yml->configs[environment].config["host_asks"].c_str(), AtoI(redis_yml->configs[environment].config["port_asks"]));
    redis_experts = redisConnect(redis_yml->configs[environment].config["host_experts"].c_str(), AtoI(redis_yml->configs[environment].config["port_experts"]));

    if (redis->err) throw runtime_error(redis->errstr);
    if (redis_search->err) throw runtime_error(redis_search->errstr);
    if (redis_resque->err) throw runtime_error(redis_resque->errstr);
    if (redis_users->err) throw runtime_error(redis_users->errstr);
    if (redis_topics->err) throw runtime_error(redis_topics->errstr);
    if (redis_asks->err) throw runtime_error(redis_asks->errstr);
    if (redis_experts->err) throw runtime_error(redis_experts->errstr);
        
    redisCommand(redis,("SELECT "+redis_yml->configs[environment].config["select"]).c_str());
    redisCommand(redis_search,("SELECT "+redis_yml->configs[environment].config["select_search"]).c_str());
    redisCommand(redis_resque,("SELECT "+redis_yml->configs[environment].config["select_resque"]).c_str());
    redisCommand(redis_users,("SELECT "+redis_yml->configs[environment].config["select_users"]).c_str());
    redisCommand(redis_topics,("SELECT "+redis_yml->configs[environment].config["select_topics"]).c_str());
    redisCommand(redis_asks,("SELECT "+redis_yml->configs[environment].config["select_asks"]).c_str());
    redisCommand(redis_experts,("SELECT "+redis_yml->configs[environment].config["select_experts"]).c_str());
  }catch(runtime_error& e){
    cerr << "While connecting to redis, caught:\n " << e.what() << endl;
    exit(1);
  }  

  try {
    #ifdef PSVRDEBUG
    cout << "Beginning Connection on " << DB_HOST+":"+DB_PORT << endl;
    #endif
    
    c.connect(DB_HOST+":"+DB_PORT);
    
    #ifdef PSVRDEBUG
    cout << "Connected ok." << endl;
    #endif
  }catch(runtime_error& e){
    cerr << "While connecting to MongoDB, caught:\n " << e.what() << endl;
    exit(2);
  }
}


typedef std::map<string, int> ret_t;
bool ret_keys_sorter(const string &k1, const string &k2, ret_t& ret) {
  return ret[k1] > ret[k2];
}

void App::topicobj_topics(const BSONObj &topic,vector<string> &topics){

  vector<be> follower_ids = topic["follower_ids"].Array();

  ret_t ret;
  BOOST_FOREACH(const BSONElement &id,follower_ids){
    BSONObj user = c.findOne(DB_NAME+".users", BSON("_id"<<id));
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
  using namespace MyNS_ForOutput;
  using namespace MyNS_Manips;
  
  string redis_cmd;
  string name;
  redisReply *redis_reply;
  BOOST_FOREACH(string &k,ret_keys){
    redis_cmd = boost::str( format("HGET %1% name") % k);
    redis_reply = (redisReply*)redisCommand(redis_topics,redis_cmd.c_str());
    if(REDIS_REPLY_STRING==redis_reply->type){
      name = redis_reply->str;
      cout << name << "("<< ret[k] << ") ";
      topics.push_back(name);
    }
    freeReplyObject(redis_reply);
  }
  cout << endl;
}

void App::start(){
  topicsSuggest();
}