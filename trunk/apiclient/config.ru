#!/usr/bin/env ruby
require 'logger'
require 'pry'
$LOAD_PATH.unshift ::File.expand_path(::File.dirname(__FILE__) + '/lib')

require 'wendao/demo'

# Set the RESQUECONFIG env variable if you've a `wendao.rb` or similar
# config file you want loaded on boot.
if ENV['RESQUECONFIG'] && ::File.exists?(::File.expand_path(ENV['RESQUECONFIG']))
  load ::File.expand_path(ENV['RESQUECONFIG'])
end

use Rack::ShowExceptions

run Wendao::Demo.new
