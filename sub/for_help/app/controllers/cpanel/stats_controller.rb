# coding: utf-8
class Cpanel::StatsController < CpanelController
  before_filter :require_stat_admin,:only=>["index","uv","visit"]
  before_filter :require_hot_ask_admin,:only=>["hot_asks","edit_hot_asks","refresh_asks"]
  before_filter :require_hot_topic_admin,:only=>["hot_topics","edit_hot_topics","refresh_topics"]
  before_filter :require_short_adv_admin,:only=>["short_adv","edit_short_adv"]
  before_filter :require_kpi_admin,:only=>["kpi"]
  def index
    @no_form_search=true
  end
  
  def visit
    @no_form_search=true
    
    @expert=Visit.where(:page=>"expert")
    @elite=Visit.where(:page=>"elite")
    @page32=Visit.where(:page=>"203432")
    @page33=Visit.where(:page=>"203433")
    @user_page=Visit.where(:page=>"user_page")
    @adv=Visit.where(:page=>"adv")
    
    if !params['datepicker_from'].blank? and !params["time_from"].blank?
      @from_time = Time.strptime params['datepicker_from']+' '+params["time_from"],"%Y-%m-%d %H:%M"
      @expert=@expert.where(:created_at.gt=>@from_time)
      @elite=@elite.where(:created_at.gt=>@from_time)
      @page32=@page32.where(:created_at.gt=>@from_time)
      @page33=@page33.where(:created_at.gt=>@from_time)
      @user_page=@user_page.where(:created_at.gt=>@from_time)
      @adv=@adv.where(:created_at.gt=>@from_time)
    elsif((!params['datepicker_from'].blank? and params["time_from"].blank?) or (params['datepicker_from'].blank? and !params["time_from"].blank?))
      flash.now[:notice]="查询时间的起始时间格式不正确！"
    end
    if !params['datepicker_to'].blank? and !params["time_to"].blank?
      @to_time = Time.strptime params['datepicker_to']+' '+params["time_to"],"%Y-%m-%d %H:%M"
      @expert=@expert.where(:created_at.lt=>@to_time)
      @elite=@elite.where(:created_at.lt=>@to_time)
      @page32=@page32.where(:created_at.lt=>@to_time)
      @page33=@page33.where(:created_at.lt=>@to_time)
      @user_page=@user_page.where(:created_at.lt=>@to_time)
      @adv=@adv.where(:created_at.lt=>@to_time)
    elsif((!params['datepicker_to'].blank? and params["time_to"].blank?) or (params['datepicker_to'].blank? and !params["time_to"].blank?))
      flash.now[:notice]="查询时间的终止时间格式不正确！"
    end
    if !@from_time.blank? and !@to_time.blank? and @from_time>@to_time
      flash.now[:notice]="查询时间的时间范围不正确！"
    end
    
  end
  
  def uv
    @no_form_search=true
    #Parameters: {"datepicker_from"=>"10/18/2011", "time_from"=>"01:00", "datepicker_to"=>"10/30/2011", "time_to"=>"02:30", "commit"=>"UV查询"}
    params['datepicker_from']=Time.now.getlocal.strftime("%Y-%m-%d") if params['datepicker_from'].blank?
    params['datepicker_to']=Time.now.getlocal.strftime("%Y-%m-%d") if params['datepicker_to'].blank?
    params["time_from"]=Time.now.getlocal.strftime("%H:%M") if params["time_from"].blank?
    params["time_to"]=Time.now.getlocal.strftime("%H:%M") if params["time_to"].blank?
    @from_time = Time.strptime params['datepicker_from']+' '+params["time_from"],"%Y-%m-%d %H:%M"
    @to_time = Time.strptime params['datepicker_to']+' '+params["time_to"],"%Y-%m-%d %H:%M"

    
    @expert_ids = User.where(is_expert:true).collect(&:id)
    @elite_ids = User.where(user_type:User::ELITE_USER).collect(&:id)

    if params[:stat_type] and params[:stat_type]=="devise"
      @asks = AskLog.where(:created_at.gt=>@from_time).and(:created_at.lt=>@to_time).and(:action=>"NEW").and(:from_mobile=>1)
      @answers = AnswerLog.where(:created_at.gt=>@from_time).and(:created_at.lt=>@to_time).and(:action=>"NEW").and(:from_mobile=>1)
      @users = User.where(:created_at.gt=>@from_time).and(:created_at.lt=>@to_time).and(:created_from_mobile=>true)
      @mobile_stat=true
    else
      @asklogs = AskLog.where(:created_at.gt=>@from_time).and(:created_at.lt=>@to_time).and(:action=>"INVITE_TO_ANSWER")
      @asks = Ask.where(:created_at.gt=>@from_time).and(:created_at.lt=>@to_time)
      @topics = Topic.where(:created_at.gt=>@from_time).and(:created_at.lt=>@to_time)
      @userlogs = UserLog.where(:created_at.gt=>@from_time).and(:created_at.lt=>@to_time).and(:action=>"FOLLOW_USER")
      @answers = Answer.where(:created_at.gt=>@from_time).and(:created_at.lt=>@to_time)
      @comments = Comment.where(:created_at.gt=>@from_time).and(:created_at.lt=>@to_time)
    
      @users = User.where(:created_at.gt=>@from_time).and(:created_at.lt=>@to_time)

      # @bads = UserLog.where(action:"THANK_ANSWER").where(:created_at.gt=>@from_time).and(:created_at.lt=>@to_time)
      @goods = UserLog.where(action:"AGREE").where(:created_at.gt=>@from_time).and(:created_at.lt=>@to_time)
      @bads = UserLog.where(action:"DISAGREE").where(:created_at.gt=>@from_time).and(:created_at.lt=>@to_time)
      @thanks = UserLog.where(action:"THANK_ANSWER").where(:created_at.gt=>@from_time).and(:created_at.lt=>@to_time)
      @invites = Log.where(action:"INVITE_TO_ANSWER").where(:created_at.gt=>@from_time).and(:created_at.lt=>@to_time)
      @mobile_stat=false
    end
    #    unless params["user"].empty?
    #      @user = User.where(email:params["user"]).first
    #      render text:'no such user' and return unless @user
    #      @users = User.where(:_id=>@user.id)
    #      @asklogs = @asklogs.and(:user_id=>@user.id)
    #      @asks = @asks.and(:user_id=>@user.id)
    #      @topics = @topics.and(:user_id=>@user.id)
    #      @userlogs = @userlogs.and(:user_id=>@user.id)
    #      @answers = @answers.and(:user_id=>@user.id)
    #      @comments = @comments.and(:user_id=>@user.id)
    #      @goods = @goods.and(:user_id=>@user.id)
    #      @thanks = @thanks.and(:user_id=>@user.id)
    #      @invites = @invites.and(:user_id=>@user.id)
    #    end
  end
  def hot_asks
    @no_form_search=true
    @created_at = SettingItem.find_or_create_by(key:'hot_asks_created_at').value.to_i
    @answers_count = SettingItem.find_or_create_by(key:'hot_asks_answers_count').value.to_i
    @refresh_minute = SettingItem.find_or_create_by(key:'hot_asks_refresh_minute').value.to_i
    @sort_by = SettingItem.find_or_create_by(key:'hot_asks_sort_by').value.to_s
  end
  def refresh_asks
    Resque.enqueue(HookerJob,'Ask',Ask.first.id,:refresh_hot_asks)
    redirect_to "/cpanel/stats/hot_asks",:notice=>"处理成功！"
  end
  def hot_topics
    @no_form_search=true
    @followers_count = SettingItem.find_or_create_by(key:'hot_topics_followers_count').value.to_i
    @asks_count = SettingItem.find_or_create_by(key:'hot_topics_asks_count').value.to_i
    @refresh_minute = SettingItem.find_or_create_by(key:'hot_topics_refresh_minute').value.to_i
    @sort_by = SettingItem.find_or_create_by(key:'hot_topics_sort_by').value.to_s
  end
  def refresh_topics
    Resque.enqueue(HookerJob,'Topic',Topic.first.id,:refresh_hot_topics)
    redirect_to "/cpanel/stats/hot_topics",:notice=>"处理成功！"
  end
  def edit_hot_asks
    created_at = SettingItem.where(key:'hot_asks_created_at').first
    answers_count = SettingItem.where(key:'hot_asks_answers_count').first
    sort_by = SettingItem.where(key:'hot_asks_sort_by').first
    created_at.update_attribute(:value,params[:hot_asks_created_at].to_i)
    answers_count.update_attribute(:value,params[:hot_asks_answers_count].to_i)
    if params[:hot_asks_sort_by] and params[:hot_asks_sort_by].to_s=="answers_count"
      sort_by.update_attribute(:value,"answers_count")
    else
      sort_by.update_attribute(:value,"last_answer_at")
    end
    redirect_to "/cpanel/stats/hot_asks",:notice=>"处理成功！"
  end
  def edit_hot_topics
    followers_count = SettingItem.where(key:'hot_topics_followers_count').first
    asks_count = SettingItem.where(key:'hot_topics_asks_count').first
    sort_by = SettingItem.where(key:'hot_topics_sort_by').first
    followers_count.update_attribute(:value,params[:hot_topics_followers_count].to_i)
    asks_count.update_attribute(:value,params[:hot_topics_asks_count].to_i)
    if params[:hot_topics_sort_by] and params[:hot_topics_sort_by].to_s=="last_followed_at"
      sort_by.update_attribute(:value,"last_followed_at")
    else
      sort_by.update_attribute(:value,"last_ask_at")
    end
    redirect_to "/cpanel/stats/hot_topics",:notice=>"处理成功！"
  end
  def short_adv
    @no_form_search=true
    @adv_img = SettingItem.where(key:'short_adv_img').first
    @adv_1 = SettingItem.where(key:'short_adv_1').first
    @adv_2 = SettingItem.where(key:'short_adv_2').first
    @adv_3 = SettingItem.where(key:'short_adv_3').first
    @adv_4 = SettingItem.where(key:'short_adv_4').first
  end
  def edit_short_adv
    adv_img = SettingItem.where(key:'short_adv_img').first
    adv_img.adv_img=params[:adv_img]
    adv_img.value=Digest::SHA1.hexdigest(Time.now.to_s)
    adv_img.desc=params[:link]
    adv_img.save
    
    adv_1 = SettingItem.where(key:'short_adv_1').first
    adv_1.value=params[:title1]
    adv_1.desc=params[:link1]
    adv_1.save
    
    adv_2 = SettingItem.where(key:'short_adv_2').first
    adv_2.value=params[:title2]
    adv_2.desc=params[:link2]
    adv_2.save
    
    adv_3 = SettingItem.where(key:'short_adv_3').first
    adv_3.value=params[:title3]
    adv_3.desc=params[:link3]
    adv_3.save
    
    adv_4 = SettingItem.where(key:'short_adv_4').first
    adv_4.value=params[:title4]
    adv_4.desc=params[:link4]
    adv_4.save
    
    redirect_to "/cpanel/stats/short_adv",:notice=>"处理成功！"
  end
  
  def kpi
    @no_form_search=true
    params[:datepicker]||=(Time.now-1.days).strftime("%Y-%m-%d")
    @stat=DailyStat.where(:created_at=>params[:datepicker]).last
    @kpi=SettingItem.where(:key=>"kpi_value").first
  end
  
  def require_stat_admin
    if !(current_user.admin_type==User::SUP_ADMIN or (current_user.admin_type==User::SUB_ADMIN and current_user.admin_area.include?("stat")))
      @no_form_search=true
      redirect_to "/cpanel/welcome",:notice=>"权限不足！"
    end
  end
  def require_hot_ask_admin
    if !(current_user.admin_type==User::SUP_ADMIN or (current_user.admin_type==User::SUB_ADMIN and current_user.admin_area.include?("hot_ask")))
      @no_form_search=true
      redirect_to "/cpanel/welcome",:notice=>"权限不足！"
    end
  end
  def require_hot_topic_admin
    if !(current_user.admin_type==User::SUP_ADMIN or (current_user.admin_type==User::SUB_ADMIN and current_user.admin_area.include?("hot_topic")))
      @no_form_search=true
      redirect_to "/cpanel/welcome",:notice=>"权限不足！"
    end
  end
  def require_short_adv_admin
    if !(current_user.admin_type==User::SUP_ADMIN or (current_user.admin_type==User::SUB_ADMIN and current_user.admin_area.include?("short_adv")))
      @no_form_search=true
      redirect_to "/cpanel/welcome",:notice=>"权限不足！"
    end
  end
  def require_kpi_admin
    if !(current_user.admin_type==User::SUP_ADMIN or (current_user.admin_type==User::SUB_ADMIN and current_user.admin_area.include?("kpi")))
      @no_form_search=true
      redirect_to "/cpanel/welcome",:notice=>"权限不足！"
    end
  end
end