#!/bin/bash
export PATH=$PATH:/usr/local/ruby/bin
export RAILS_ENV=production
cd /var/www/html/quora
/usr/local/ruby/bin/bundle exec rake update:cache >> /tmp/wendao.log 2>&1
