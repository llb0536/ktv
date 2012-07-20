# coding: utf-8
class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:auth_callback]
  before_filter :init_user, :except => [:auth_callback]
  before_filter :we_are_inside_qa
  def we_are_inside_qa
    @we_are_inside_qa = true
  end
  def init_user
    @user = User.find_by_slug(params[:id])
    @user = User.find_by_slug(params[:id].force_encoding_zhaopin.split('_').join('.')) if @user.blank? or !@user.deleted.blank?
    if @user.blank? or !@user.normal_deleting_status(current_user)
      render_404
    end
    @ask_to_user = Ask.new
  end

  def answered
    @per_page = 10
    @asks = Ask.recent.any_in(_id:@user.answered_ask_ids)
    .nondeleted()
    .paginate(:page => params[:page], :per_page => @per_page)
    set_seo_meta("#{@user.name}回答过的问题")
    if params[:format] == "js"
      render "/users/answered_asks.js"
    end
  end
  
  def asked_to
    @per_page = 10
    @asks = Ask.asked_to(@user.id)
    if params[:filter]=='new'
      @asks = @asks.unanswered
    end
    @asks = @asks.recent.nondeleted
    .paginate(:page => params[:page], :per_page => @per_page)
    
    set_seo_meta("问#{@user.name}的问题")

    if params[:format] == "js"
      render "/asks/index.js"
    else
      render "asked"
    end
  end

  def show
    pagination_get_ready    
    @coursewares = @user.coursewares.normal.order('id desc')
    pagination_over(@coursewares.count)
    @coursewares = @coursewares.paginate(:page => @page, :per_page => @per_page)
    
    @per_page = 10
    @logs = []
    actions=[]
    times={}
    logs = Log.where(:user_id => @user.id).where(:action.ne=>"ADD_TOPIC").desc("created_at")
    logs.each do |log|
      if ["AskLog","AnswerLog"].include?(log._type) and ["NEW","EDIT"].include?(log.action) and actions.include?(log._type+"_"+log.target_id.to_s) and (log.created_at+2.days)>times[log._type+"_"+log.target_id.to_s]
      else
        @logs<<log
        times[log._type+"_"+log.target_id.to_s]=log.created_at
        if !actions.include?(log._type+"_"+log.target_id.to_s)
          actions<<log._type+"_"+log.target_id.to_s
        end
      end
    end
    @logs=@logs.paginate(:page => params[:page], :per_page => @per_page)
    set_seo_meta(@user.name)
    if params[:format] == "js"
      render "/logs/index.js"
    end
    
    render "show#{@subsite}"
  end

  def asked
    @per_page = 10
    @asks = @user.asks.recent
    .nondeleted
    .paginate(:page => params[:page], :per_page => @per_page)
    set_seo_meta("#{@user.name}问过的问题")
    if params[:format] == "js"
      render "/asks/index.js"
    end
  end
  
  def following_topics
    @per_page = 20
    @topics = @user.followed_topic_ids.reverse
    .paginate(:page => params[:page], :per_page => @per_page)
    
    set_seo_meta("#{@user.name}关注的课程")
    if params[:format] == "js"
      render "following_topics.js"
    end
  end
  
  def followers
    @per_page = 20
    @followers = @user.follower_ids.reverse
    .paginate(:page => params[:page], :per_page => @per_page)
    
    set_seo_meta("关注#{@user.name}的人")
    if params[:format] == "js"
      render "followers.js"
    end
  end
  
  def following
    @per_page = 20
    @followers = @user.following_ids.reverse
    .paginate(:page => params[:page], :per_page => @per_page)
    
    set_seo_meta("#{@user.name}关注的人")
    if params[:format] == "js"
      render "followers.js"
    else
      render "followers"
    end
  end
  
  def follow
    if not @user
      render :text => "0"
      return
    end
    current_user.follow(@user)
    render :text => "1"
  end
  
  def unfollow
    if not @user
      render :text => "0"
      return
    end
    current_user.unfollow(@user)
    render :text => "1"
  end

  def auth_callback
		auth = request.env["omniauth.auth"]  
		redirect_to root_path if auth.blank?
    provider_name = auth['provider'].gsub(/^t/,"").titleize
    Rails.logger.debug { auth }

		if current_user
      Authorization.create_from_hash(auth, current_user)
      flash[:notice] = "成功绑定了 #{provider_name} 账号。"
			redirect_to edit_user_registration_path
		elsif @user = Authorization.find_from_hash(auth)
      sign_in @user
			flash[:notice] = "登录成功。"
			redirect_to "/"
		else
      if Setting.allow_register
        @new_user = Authorization.create_from_hash(auth, current_user) #Create a new user
        if @new_user.errors.blank?
          sign_in @new_user
          flash[:notice] = "欢迎来自 #{provider_name} 的用户，你的账号已经创建成功。"
          redirect_to "/"
        else
          flash[:notice] = "#{provider_name}的账号提供信息不全，无法直接登录，请先注册。"
          redirect_to "/register"
        end
      else
        flash[:alert] = "你还没有注册用户。"
        redirect_back_or_default "/login"
      end
		end
  end

end
