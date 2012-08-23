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
    @get = @post = {}
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
    send(@get['action'])
  end
  def test
    render text:API_RETURN_SUCCEED
  end
  
end