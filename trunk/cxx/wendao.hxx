#pragma once
#include <iostream>
#include <algorithm>
#include <vector>
#include <map>
#include <iomanip>

#include <boost/version.hpp>
#include <boost/foreach.hpp>
#include <boost/lambda/lambda.hpp>
#include <boost/lambda/bind.hpp>
#include <boost/bind.hpp>
#include <boost/thread.hpp>
#include <boost/program_options.hpp>
#include <boost/format.hpp>
#include <boost/utility.hpp>

#include <mongo/client/dbclient.h>
#include <hiredis/hiredis.h>

using namespace mongo;
using namespace bson;
namespace po = boost::program_options;

#include "rails_yml.hxx"
#include "app.hxx"

namespace MyNS_ForOutput {
  using std::cout; using std::cerr;
  using std::string;
  using std::endl; using std::flush;

  using boost::format;
  using boost::io::group;
}

namespace MyNS_Manips {
  using std::setfill;
  using std::setw;
  using std::hex ;
  using std::dec ;
// gcc-2.95 doesnt define the next ones
//  using std::showbase ;
//  using std::left ;
//  using std::right ;
//  using std::internal ;
}


extern string DB_HOST;
extern string DB_PORT;
extern string DB_NAME;

extern RailsYml *mongoid_yml;
extern RailsYml *redis_yml;
extern RailsYml *suggest_yml;

extern string environment;
int AtoI(string &input);