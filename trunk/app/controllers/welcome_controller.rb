# -*- encoding : utf-8 -*-
class WelcomeController < ApplicationController
  def surprise
    
  end
  def index
    @seo[:title] = '首页'
    if @subsite.present?
      render "index#{@subsite}",:layout=>false
    else
      @courseware = Courseware.find(Setting.ktv_courseware_id)
      @latest_user = User.already_confirmed.recent.first
      @hottest_user = UserCache.where(:hot_rank => 1).first.user
      @latest_cw = Courseware.normal.nondeleted.desc(:created_at).limit(4)
      @topics_users = User.expert_with_topic(:without => [Setting.zuozheqingqiu_id,@hottest_user.id] + (current_user ? [current_user.id] : []))
    end
  end
  def inactive_sign_up
    render "inactive_sign_up#{@subsite}",layout:'application_for_devise'
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
  
  def top
    render "top#{@subsite}",:layout=>false
  end
  def menu
    render "menu#{@subsite}",:layout=>false
  end
  def xi
    render "xi#{@subsite}",:layout=>false
  end
  def main
    render text:'todo'
  end
end
