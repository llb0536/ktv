# coding: utf-8
class UcenterController < ApplicationController
  def uc
    get = post = []
    code = params[:code]
    puts code
    decoded = UCenter::Php.authcode(code,'DECODE',UCenter.getdef('UC_KEY'))
    UCenter::Php.parse_str(decoded,get)
    binding.pry
    # render text:"#{text}" and return
  end
  
end