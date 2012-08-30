How to Deploy this app?

0.

export RAILS_ENV=production

bundle install --without development:test



1.

RAILS_ENV=production bundle exec rake assets:precompile

2.

ensure Nginx is compiled with --with-http_gzip_static_module

http{
  gzip on
  gzip_http_version       1.1;
  gzip_disable            "msie6";
  gzip_vary               on;
  gzip_min_length         1100;
  gzip_buffers            64 8k;
  gzip_comp_level         3;
  gzip_proxied            any;
  gzip_types              text/plain text/css application/x-javascript text/xml application/xml;

 
  location ~* ^/assets {
    gzip_static on;
    expires max;
    add_header Cache-Control public;
    access_log /dev/null; error_log /dev/null; 
    break;
  }

}

3.

edit config

6379 推荐
6380 Redis-Search
6381 Resque
6382 User缓存
6383 Topic缓存
6384 Ask缓存
6385 专家缓存

4.
rake tasks
see readme_tasks

5.
run_resque

6.
rake naughty:words

7.

cd apidoc
rake compile
cd ..
rake db:seed
