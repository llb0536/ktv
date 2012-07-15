#include "rails_yml.hxx"
#include <assert.h>
#include <boost/format.hpp>
using boost::format;
using boost::io::group;

RailsConfig::RailsConfig(RailsYml &yml,yaml_parser_t &parser, yaml_event_t &event){
  string key,value;
  string anchor;
  while(1){
    yaml_parser_parse(&parser, &event);
    if(YAML_MAPPING_END_EVENT==event.type){
      break;
    }
    assert(YAML_SCALAR_EVENT==event.type);
    key = string(reinterpret_cast<const char*>(event.data.scalar.value));
    yaml_parser_parse(&parser, &event);
    if(YAML_SCALAR_EVENT==event.type){
      value = string(reinterpret_cast<const char*>(event.data.scalar.value));
      this->config[key] = value;
      // cout << key <<" "<< value<<endl;
    }else if(YAML_ALIAS_EVENT==event.type){
      anchor = string(reinterpret_cast<const char*>(event.data.alias.anchor));
      assert(yml.environments.end() != find(yml.environments.begin(),yml.environments.end(),anchor));
      BOOST_FOREACH(const config_t::value_type &i, yml.configs[anchor].config){
        // cout << i.first <<" "<< i.second<<endl;
        this->config[i.first] = i.second;
      }
    }else{
      throw runtime_error(str(format("read_configs encountered unknown format %1%") % event.type));
    }
    // case YAML_SEQUENCE_START_EVENT: puts("<b>Start Sequence</b>"); break;
    // case YAML_SEQUENCE_END_EVENT:   puts("<b>End Sequence</b>");   break;
    yaml_event_delete(&event);
  }
}

void RailsYml::read_enviroments(yaml_parser_t &parser, yaml_event_t &event){
  while(1){
    yaml_parser_parse(&parser, &event);
    if(YAML_MAPPING_END_EVENT==event.type){
      break;
    }
    assert(YAML_SCALAR_EVENT == event.type);
    string new_env(reinterpret_cast<const char*>(event.data.scalar.value));
    environments.push_back(new_env);
    yaml_parser_parse(&parser, &event);
    
    assert(YAML_MAPPING_START_EVENT == event.type);
    // cout << "YAML_MAPPING_START_EVENT" << endl;
    RailsConfig rc(*this, parser, event);
    // cout << "YAML_MAPPING_END_EVENT" << endl;
    assert(YAML_MAPPING_END_EVENT == event.type);
    
    this->configs.insert( pair<string,RailsConfig>(new_env,rc) );
    yaml_event_delete(&event);
  }
}

RailsYml::RailsYml(const char* filepath){
  FILE *fh = fopen(filepath, "r");
  yaml_parser_t parser;
  yaml_event_t  event;   /* New variable */

  /* Initialize parser */
  if(!yaml_parser_initialize(&parser))
    throw runtime_error("Failed to initialize parser!");
  if(fh == NULL)
    throw runtime_error("Failed to open file!");

  /* Set input file */
  yaml_parser_set_input_file(&parser, fh);

  do{
    /* START new code */
    yaml_parser_parse(&parser, &event);
    switch(event.type)
    { 
      case YAML_NO_EVENT: throw runtime_error("No event!"); break;
      /* Block delimeters */
      case YAML_MAPPING_START_EVENT:
        read_enviroments(parser, event);
        break;
      /* Data */
      case YAML_ALIAS_EVENT:
      case YAML_SCALAR_EVENT:
        throw runtime_error("unexpected data outside environments scope");
        break;
    }
    if(event.type != YAML_STREAM_END_EVENT)
      yaml_event_delete(&event);
  }while(event.type != YAML_STREAM_END_EVENT);
  yaml_event_delete(&event);
  /* END new code */

  /* Cleanup */
  yaml_parser_delete(&parser);
  fclose(fh);
}