#!/bin/bash
export PATH=$PATH:/usr/local/ruby/bin
cd /var/www/html/quora

echo "" > log/thin.3000.log
echo "" > log/thin.3001.log
echo "" > log/thin.3002.log
echo "" > log/thin.3003.log
echo "" > log/thin.3004.log

/usr/local/ruby/bin/bundle exec rake mail:sendpack >> /tmp/wendao.log 2>&1
/usr/local/ruby/bin/bundle exec rake cache:update >> /tmp/wendao.log 2>&1
#/usr/local/ruby/bin/bundle exec rake search:index  >> /tmp/wendao.log 2>&1
