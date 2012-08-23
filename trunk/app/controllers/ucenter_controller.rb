# coding: utf-8
class UcenterController < ApplicationController
  API_RETURN_SUCCEED = '1'
  # -- psvr sep --
  API_DELETEUSER = 1
  API_RENAMEUSER = 1
  API_GETTAG = 1
  API_SYNLOGIN = 1
  API_SYNLOGOUT = 1
  API_UPDATEPW = 1
  API_UPDATEBADWORDS = 1
  API_UPDATEHOSTS = 1
  API_UPDATEAPPS = 1
  API_UPDATECLIENT = 1
  API_UPDATECREDIT = 1
  API_GETCREDIT = 1
  API_GETCREDITSETTINGS = 1
  API_UPDATECREDITSETTINGS = 1
  API_ADDFEED = 1
  API_RETURN_FAILED = '-1'
  API_RETURN_FORBIDDEN = '1'
  # --------------
  def ktv_uc_client
    @get = {}
    code = params[:code]
    decoded = UCenter::Php.authcode(code,'DECODE',UCenter.getdef('UC_KEY'))
    UCenter::Php.parse_str(decoded,@get)
  	if(UCenter::Php.time() - @get['time'].to_i > 3600)
  		render text:'Authracation has expiried'
  		return
  	end
  	if(@get.blank?)
  		render text:'Invalid Request'
  		return
  	end
  	post_str = request.body.read
  	@post = Nokogiri::XML(post_str) if post_str.present?
  	puts "[[[#{@get['action']}]]]"
  	pp(Hash.from_xml(post_str)) if @post.present?
    send(@get['action'])
  end
  def updateapps
=begin
<?xml version="1.0" encoding="ISO-8859-1"?>
<root>
    <item id="1">
        <item id="appid"><![CDATA[1]]></item>
        <item id="type"><![CDATA[DISCUZX]]></item>
        <item id="name"><![CDATA[Kejian.TV 目录检索]]></item>
        <item id="url"><![CDATA[http://kejian.lvh.me/simple]]></item>
        <item id="ip"><![CDATA[]]></item>
        <item id="viewprourl"><![CDATA[]]></item>
        <item id="apifilename"><![CDATA[uc.php]]></item>
        <item id="charset"><![CDATA[utf-8]]></item>
        <item id="synlogin"><![CDATA[1]]></item>
        <item id="extra">
            <item id="apppath"><![CDATA[]]></item>
            <item id="extraurl"></item>
        </item>
        <item id="recvnote"><![CDATA[1]]></item>
    </item>
    <item id="3">
        <item id="appid"><![CDATA[3]]></item>
        <item id="type"><![CDATA[KTV]]></item>
        <item id="name"><![CDATA[ktv]]></item>
        <item id="url"><![CDATA[http://kejian.lvh.me]]></item>
        <item id="ip"><![CDATA[]]></item>
        <item id="viewprourl"><![CDATA[]]></item>
        <item id="apifilename"><![CDATA[uc]]></item>
        <item id="charset"><![CDATA[]]></item>
        <item id="synlogin"><![CDATA[1]]></item>
        <item id="extra">
            <item id="apppath"><![CDATA[]]></item>
            <item id="extraurl"></item>
        </item>
        <item id="recvnote"><![CDATA[1]]></item>
    </item>
    <item id="UC_API"><![CDATA[http://uc.kejian.lvh.me]]></item>
</root>
=end
    render text:API_RETURN_SUCCEED
  end
  def test
    render text:API_RETURN_SUCCEED
  end
  
end