# -*- encoding : utf-8 -*-
class WelcomeController < ApplicationController
  def index
    @seo[:title] = '讲义·作业·复习资料·往年试卷·课堂录像'
    # @course = Course.find(Setting.ktv_course_id)
    # @courseware = Courseware.find(Setting.ktv_courseware_id)
    @newest_cw = Courseware.normal.order('id desc').limit(9)
  end
  def inactive_sign_up
    render layout:'application_for_devise'
  end
  def about
    
  end
  def shuffle
    redirect_to Courseware.skip(rand(Courseware.count)).first
  end
end
