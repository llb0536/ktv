# -*- encoding : utf-8 -*-
class WelcomeController < ApplicationController
  def index
    redirect_to '/home/index' and return if '__cnu'==@subsite
    @seo[:title] = '讲义·电子书·课堂录像·习题解答·互动交流'
    render "index#{@subsite}"
  end
  def inactive_sign_up
    render "inactive_sign_up#{@subsite}",layout:'application_for_devise'
  end
  def about
    @seo[:title] = '关于我们'
  end
  def shuffle
    cw = nil
    i = 0
    while !(cw and 0==cw.status and !cw.deleted?)
      cw = Courseware.skip(rand(Courseware.count)).first
      i += 1
      if i>10
        redirect_to '/'
        return
      end
    end
    redirect_to cw
  end
end
