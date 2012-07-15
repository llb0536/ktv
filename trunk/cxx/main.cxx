#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "wendao.hxx"
#include <sstream>
#include <assert.h>
int AtoI(string &input){
  int temp;
  stringstream ssout(input);
  ssout>>temp;
  return temp;
}

string DB_HOST;
string DB_PORT;
string DB_NAME;

RailsYml *mongoid_yml;
RailsYml *redis_yml;
RailsYml *suggest_yml;

string environment;
  
int main(int argc, char **argv){
  assert(1 == BOOST_VERSION / 100000);
  // assert((BOOST_VERSION / 100) % 1000 >= 48);
  
  try{
    int getopt_ret;
    while ((getopt_ret = getopt (argc, argv, "e:")) != -1){
      switch (getopt_ret){
        case 'e':
          environment = string(optarg);
          break;
        case '?':
          if (optopt == 'e')
            fprintf (stderr, "Option -%c requires an argument.\n", optopt);
          else if (isprint (optopt))
            fprintf (stderr, "Unknown option `-%c'.\n", optopt);
          else
            fprintf (stderr,
                     "Unknown option character `\\x%x'.\n",
                     optopt);
          return 1;
        default:
          cerr << "Unkown behavior of getopts." << endl;
          return 100;
      }
    }
    for (int index = optind; index < argc; index++)
      printf ("Non-option argument %s\n", argv[index]);
    if(environment.empty()){
      cerr << "No -e [env] options given, defaults to development." << endl;
      environment = "development";
    }
  }catch(runtime_error& e){
    cerr << "While reading program options, caught:\n " << e.what() << endl;
  }
  
  try{
    mongoid_yml = new RailsYml("../config/mongoid.yml");
    redis_yml = new RailsYml("../config/redis.yml");
    suggest_yml = new RailsYml("../config/suggest.yml");

    #ifdef PSVRDEBUG
    BOOST_FOREACH(RailsConfig::config_t::value_type &i, mongoid_yml->configs[environment].config){
      cout << i.first << " " << i.second << endl;
    }
    #endif
    
    DB_HOST = mongoid_yml->configs[environment].config["host"];
    DB_PORT = mongoid_yml->configs[environment].config["port"];
    DB_NAME = mongoid_yml->configs[environment].config["database"];
    
    if(0==DB_HOST.size()){throw runtime_error("Critical config missing: host");}
    if(0==DB_PORT.size()){DB_PORT="27017";}
    if(0==DB_NAME.size()){throw runtime_error("Critical config missing: quora_development");}
  }catch(runtime_error& e){
    cerr << "While reading yaml config, caught:\n " << e.what() << endl;
  }
  cout << "Wendao Suggest Upon Mongo Database: " << DB_NAME << endl;
  
  cout << "Everything loaded." << endl;


  // ----------------------------------------------------------------------------------  
  // Everything loaded.----------------------------------------------------------------
  // ----------------------------------------------------------------------------------
  
  try{
    // vector<App*> apps;
    // boost::thread_group threads;
    // int cpu_cores = AtoI(suggest_yml->configs[environment].config["cpu_cores"]);
    // for(int core=0;core<cpu_cores;++core){
    //   cout << "Thread "<<core<< "starting...";
    //   apps.push_back(new App(core,cpu_cores));
    //   threads.add_thread(new thread(&App::start, apps[core]));
    //   cout << "OK" << endl;
    // }
    // cout << "Joining." << endl;
    // threads.join_all();
    // cout << "All Done." << endl;
    
    App app(1,1);
    app.start();
  }catch( DBException &e ) {
    cerr << "App Thrown: " << e.what() << endl;
  }
  
  return 0;
}