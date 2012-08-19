# coding: utf-8
class UcenterController < ApplicationController
  def uc
    code = params[:code]
    text = UCenter::Php.authcode(code,'DECODE',UCenter.getdef('UC_KEY'))
    puts text
    render text:"#{text}" and return
  end
  
end