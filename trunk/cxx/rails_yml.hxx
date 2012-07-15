#pragma once
#include <yaml.h>
#include <string>
#include <map>
#include <vector>
#include <boost/foreach.hpp>
#include <iostream>
#include <stdexcept>

using namespace std;
// TODO: support hosts [array]

struct RailsYml;
struct RailsConfig{  
  RailsConfig(){throw runtime_error("Orphaned RailsConfig instantiated.");}
  RailsConfig(RailsYml &yml,yaml_parser_t &parser, yaml_event_t &event);
  typedef map<string,string> config_t;
  // string &operator[] (string &field) const {return this->config[field];}
  config_t config;
};



struct RailsYml{
  RailsYml(const char* filepath);
  void read_enviroments(yaml_parser_t &parser, yaml_event_t &event);
  vector<string> environments;
  map<string,RailsConfig> configs;
};


struct MongoidYml : public RailsYml{
};


struct MongoidConfig : public RailsConfig{
  string host;
  string database;
};