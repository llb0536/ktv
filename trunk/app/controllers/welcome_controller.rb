# -*- encoding : utf-8 -*-
class WelcomeController < ApplicationController
  def index
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
    redirect_to Courseware.skip(rand(Courseware.count)).first
  end
end
