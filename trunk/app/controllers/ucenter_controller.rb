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
  
  def test
    render text:API_RETURN_SUCCEED
  end
  def deleteuser
    binding.pry
  end
  def renameuser
    binding.pry
  end
  def deletefriend
    binding.pry
  end
  def gettag
    binding.pry
  end
  def getcreditsettings
    binding.pry
  end
  def getcredit
    binding.pry
  end
  def updatecreditsettings
    binding.pry
  end
  def updateclient
    binding.pry
  end
  def updatepw
    binding.pry
  end
  def updatebadwords
    binding.pry
  end
  def updatehosts
    binding.pry
  end
  def updateapps
    render text:API_RETURN_SUCCEED
=begin
{"root"=>
  {"item"=>
    [{"id"=>"1",
      "item"=>
       ["1",
        "DISCUZX",
        "Kejian.TV ç\u009B®å½\u0095æ£\u0080ç´¢",
        "http://kejian.lvh.me/simple",
        {"id"=>"ip", "__content__"=>""},
        {"id"=>"viewprourl", "__content__"=>""},
        "uc.php",
        "utf-8",
        "1",
        {"id"=>"extra",
         "item"=>
          [{"id"=>"apppath", "__content__"=>""},
           {"id"=>"extraurl", "__content__"=>"\t\t\t"}]},
        "1"]},
     {"id"=>"3",
      "item"=>
       ["3",
        "KTV",
        "ktv",
        "http://kejian.lvh.me",
        {"id"=>"ip", "__content__"=>""},
        {"id"=>"viewprourl", "__content__"=>""},
        "uc",
        {"id"=>"charset", "__content__"=>""},
        "1",
        {"id"=>"extra",
         "item"=>
          [{"id"=>"apppath", "__content__"=>""},
           {"id"=>"extraurl", "__content__"=>"\t\t\t"}]},
        "1"]},
     "http://uc.kejian.lvh.me"]}}
=end
  end
  def updatecredit
    binding.pry
  end
  def synlogin
    sign_in User.authenticate_through_ucenter!(@get)
    render text:API_RETURN_SUCCEED
  end
  def synlogout
    harsh_sign_out
    render text:API_RETURN_SUCCEED
  end
end