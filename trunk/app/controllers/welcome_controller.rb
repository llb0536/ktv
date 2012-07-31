# -*- encoding : utf-8 -*-
class WelcomeController < ApplicationController
  def surprise
    
  end
  def index
    @seo[:title] = '首页'
    @courseware = Courseware.find(Setting.ktv_courseware_id)
    @latest_user = User.already_confirmed.recent.first
    @hottest_user = UserCache.where(:hot_rank => 1).first.user
    @latest_cw = Courseware.normal.desc(:created_at).limit(4)
    @topics_users = []
    users = User.where(:expert_topic.ne=>nil,:_id.nin=>[current_user.id,Setting.zuozheqingqiu_id,@hottest_user.id]) #todo: .where(:confirmed_at.ne=>nil)
    (0..users.count-1).sort_by{rand}.slice(0, 4).each do |i|
      u = users.skip(i).first
      t = Topic.locate u.expert_topic
      @topics_users << [t,u]
    end
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
