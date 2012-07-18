# -*- encoding : utf-8 -*-

CONFIG={
  username:'weruioruew82@qq.com',
  password:'pmqpmq',
  threshold: 3000
}



require 'active_support/all'
require 'ostruct'
require 'uri'
require 'cgi'
require 'mechanize'
require 'pry'

agent = Mechanize.new
agent.user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:12.0) Gecko/20100101 Firefox/12.0"
BKURL = 'http://kejian.tv/newbie'
res = agent.post('http://my.kejian.tv/loginmgr/loginproc.asp',
  {
    Validate: 'campusspecial2011unify',
    bkurl: BKURL,
    errbkurl: BKURL.reverse,
    loginname: CONFIG[:username],
    password: CONFIG[:password]
  },
  {
    'Referer' => 'http://kejian.tv/newbie',
  }
)
raise '登录讯息不正确！' unless res.parser.css('meta').to_s.include?(BKURL)
page = agent.get BKURL
p code = page.parser.css('input[name=authenticity_token]').first.attribute('value').value
1.upto(CONFIG[:threshold]) do |i|
  p title =  "tmp_#{rand}"
  res = agent.post('http://kejian.tv/asks',
                   {
'ask[body]' => title, 
'ask[title]' => "tmp_#{rand}",
'authenticity_token' => code,
'topic' => '',
'topics' => ''
  },
    {
    'Referer'=>'http://kejian.tv/asks'
  }
                  )
  code = page.parser.css('input[name=authenticity_token]').first.attribute('value').value
end
