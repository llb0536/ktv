# -*- encoding : utf-8 -*-
class WelcomeController < ApplicationController
  def index
    @seo[:title] = '讲义·电子书·课堂录像·习题解答·互动交流'
    # @course = Course.find(Setting.ktv_course_id)
    # @courseware = Courseware.find(Setting.ktv_courseware_id)
    @newest_cw = Courseware.normal.order('id desc').limit(9)
  end
  def inactive_sign_up
    render layout:'application_for_devise'
  end
  def about
    @seo[:title] = '关于我们'
  end
  def shuffle
    redirect_to Courseware.skip(rand(Courseware.count)).first
  end
end
