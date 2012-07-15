# coding: utf-8
@chenggong=0
@shibai=0
      def bao10jie_sig(canshu)
        canshu
        canshu_a  = canshu.sort
        pinjie = []
        canshu_a.each do |item|
          pinjie << "#{item[0]}=#{item[1]}"
        end
        pinjie = pinjie.join('&')
        pinjie+=Bao10jie::Config::APP_KEY
        Digest::MD5.hexdigest(pinjie)
      end
      require File.expand_path("./config/initializers/bao10jie.rb",Rails.root)
    def bao10jie_ping
        
      url = URI.parse(Bao10jie::Config::PURIFY_API)
      proxy_addr = '192.168.20.6'
      proxy_port = 3128

      req = Net::HTTP::Post.new(url.path)
      bao10fied = 'falungong'

      xml = <<HERE
<?xml version="1.0" encoding="utf-8"?>
<contents>
  <content>
    <class>11</class>
    <textId>324</textId>
    <url>http://www.sina.com/1.htm</url>
    <title>标题</title>
    <text><![CDATA[#{bao10fied}]]></text>
    <author>网名</author>
    <userId>xxxx</userId>
    <ip>0.0.0.0</ip>
    <pubDate>#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}</pubDate>
    <threadId>34553</threadId>
    <authorEx>扩展</authorEx>
    <contentEx>扩展</contentEx>
    <structureEx>扩展</structureEx>
    <rules></rules>
  </content>
</contents>
HERE
      canshu = {
        'format'=>'JSON',
        'appid'=>Bao10jie::Config::APP_ID,
        'appType'=>Bao10jie::Config::APP_TYPE,
        'v'=>'2.0',
        'time'=>Time.now.to_i,
        'transId'=>Bao10jie::Config::TRANS_ID,
        'param'=>xml
      }
      canshu['sig']=bao10jie_sig(canshu)
  debug=''
      req.set_form_data(canshu)
      #render text:req.body and return
      #res = Net::HTTP::Proxy(proxy_addr,proxy_port).start(url.host, url.port) {|http| http.request(req) }
begin
       res = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }

      case res
      when Net::HTTPSuccess, Net::HTTPRedirection
        bao10result = JSON.parse(res.body)
       #render text:bao10result and return
        p bao10result
                @chenggong += 1
      else
        res.error!
      end
rescue => e
  p e
  @shibai +=1
end
end



namespace :bao10jie do
  task :ping do
    require 'benchmark'
    
1000.times do |i|
  Benchmark.bm (7) do |x|
    x.report ("bao10jie_ping:") {bao10jie_ping}
  end
  p "sum=#{i}; suc=#{@chenggong},failed=#{@shibai},failing_rate=#{@shibai*1.0/i}"
end

  end
end