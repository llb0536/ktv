# coding: utf-8
require 'digest/md5'
require 'net/http'
require 'uri'
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter proc{
    # text =request.env['HTTP_USER_AGENT']
    # render text:"#{text}" and return
  }
  if Rails.env.production?
    rescue_from Exception, with: :render_500
    rescue_from AbstractController::ActionNotFound, with: :render_404
    rescue_from ActionController::RoutingError, with: :render_404
    rescue_from ActionController::UnknownController, with: :render_404
    rescue_from ActionController::UnknownAction, with: :render_404
  end
  def render_401(exception=nil)
    redirect_to root_path,:alert => '对不起，权限不足！'
  end
  def render_404(exception=nil)
    @not_found_path = exception ? exception.message : ''
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404.html", layout: false, status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end
  def render_500(exception=nil)
    @not_found_path = exception ? exception.message : ''
    if e = exception
      str = "#{Time.now.getlocal}\n"
      str += "#{request.request_method} #{request.path} #{request.ip}\n"
      str += "#{request.user_agent}\n"
      str += e.message+"\n"+e.backtrace.join("\n")
      str += "\n---------------------------------------------\n"
      $debug_logger.fatal(str)
    end
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/500.html", layout: false, status: 500 }
      format.all { render nothing: true, status: 500 }
    end
  end
  before_filter :set_vars,:xookie
  before_filter :unknown_user_check

  def set_vars
    @subsite = Ktv::Subdomain.match(request)
    @seo = Hash.new('')
    agent = request.env['HTTP_USER_AGENT'].downcase
    @is_bot = (agent.match(/\(.*https?:\/\/.*\)/)!=nil)
    @is_ie = (agent.index('msie')!=nil)
    @is_ie6 = (agent.index('msie 6')!=nil)
    @is_ie7 = (agent.index('msie 7')!=nil)
    @is_ie8 = (agent.index('msie 8')!=nil)
    @is_ie9 = (agent.index('msie 9')!=nil)
    @is_ie10 = (agent.index('msie 10')!=nil)
  end
  def xookie
    sui = cookies["JSsUserInfo"]
    pui = cookies["JSpUserInfo"]
    if current_user.nil?
      # u = User.
      # if u
      #   u.update_attribute("last_login_at",Time.now)
      #   u.inc(:login_times,1)
      #   LoginLog.create(:user_id=>u.id,:login_at=>Time.now,:range=>(Time.now.to_date-u.created_at.to_date).to_i)
      #   sign_in(u)
      # end
    end
  end
  layout :layout_by_resource
  def layout_by_resource
    if devise_controller? and (not '__cnu'==@subsite)
      "application_for_devise#{@subsite}"
    elsif request.path.starts_with?('/embed/')
      "embedded"
    else
      "application#{@subsite}"
    end
  end
  before_filter :decide_sub_main
  def decide_sub_main
    if '1'==params['force_main']
      return go_main!
    elsif '1'==params['force_sub']
      return go_sub! 
    elsif @subsite.present?
      return true
    else
      if go_nowhere?
        return go_sub!
      else
        return go_main!
      end
    end
  end
  def go_nowhere?
    return (@is_ie6 or @is_ie7 or @is_ie8)
  end
  def go_sub!
    redirect_to '/simple'
    return false
  end
  def go_main!
    if go_nowhere?
      modern_required
      return false
    end
    @application_ie_modern_required = false
    return true
  end
  before_filter :check_user_logged_in,:unless=>proc{|controller_instance|devise_controller?}
  def check_user_logged_in
    unless Setting.allow_register
      if !user_signed_in?
        @seo[:title]='请登录或获取注册邀请'
        user_logged_in_required
        return false
      else
        return true
      end
    end
  end
  

  helper :all
  before_filter :load_notice
  before_filter Proc.new{
    # render text:request.subdomain and return
    # $redis.incr('stat1231')  if 'http://article.kejian.tv/zt/2011/1231.html'==request.referer
  
  if user_signed_in?
    if current_user.banished.present? and (current_user.banished=="1" or current_user.banished==true)
      render file:'shared/banished' and return
    end
  end
  }
  before_filter Proc.new{
    params[:page]='0' if ''==params[:page]
  
  } 

  before_filter :set_some_variables
  def set_some_variables
    unless request.env['HTTP_USER_AGENT'].nil?
      @is_ie = (request.env['HTTP_USER_AGENT'].downcase.index('msie')!=nil)
      @is_ie6 = (request.env['HTTP_USER_AGENT'].downcase.index('msie 6')!=nil)
      @is_ie9 = (request.env['HTTP_USER_AGENT'].downcase.index('msie 9')!=nil)
    end
  end

  def bugtrack
    redirect_to '/asks/4ea0de69d1212f2c4d000006'
    return
  end
  def load_notice
    @notice = Notice.open_notice.last
  end
  
  # 暂时不使用mobile-fu的功能，仅仅使用其is_mobile_device?方法
  #include ActionController::MobileFu::InstanceMethods
  #helper_method :is_mobile_device?
  
  def nb
    @follower=User.last
    @invitors=[User.last]
    @ask=Ask.first
    @answer=Answer.first
    @user=User.last
    render file:"/user_mailer/#{params[:file]}",:layout=>'tmp'
  end
  # set page title, meta keywords, meta description
  def set_seo_meta(title, options = {})
    #todo
    keywords = options[:keywords] || "问答"
    description = options[:description] || "Kejian.TV 课件交流系统是中国最大的教育资源在线集散平台，同时，课件交流系统也是中国最专业的在线学习社区。"

    if title.length > 0
      @seo[:title] = "#{title}"
    end
    @seo[:keywords] = keywords
    @seo[:description] = description
  end


  def render_optional_error_file(status_code)
    @render_no_sidebar = true
    status = status_code.to_s
    @raw_raw_raw = true
    if ["404", "422", "500"].include?(status)
      render :template => "/errors/#{status}.html.erb", :status => status, :layout => "application"
    else
      render :template => "/errors/unknown.html.erb", :status => status, :layout => "application"
    end
  end
  
  def store_location
    session[:return_to] = request.request_uri
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  def unknown_user_check
    if current_user
      unknowns = []
      unknowns << '真实姓名' if current_user.name_unknown
      unknowns << '邮箱地址' if current_user.email_unknown
      unknowns << '密码' if current_user.encrypted_password.blank?
      unless unknowns.blank?
        flash[:insuf_info] = "请<a href=\"#{edit_user_registration_path}\">点击这里</a>补充您的#{unknowns.join '和'}".html_safe 
      else
        flash[:insuf_info] = nil
      end
    end
  end

  
  def require_admin
    if current_user.blank?
      #@simple_cpanel_layout=true
      #render "cpanel/users/login"
      render file:"#{Rails.root}/public/999.html",layout:false
      return
    end
    if ![User::SUP_ADMIN,User::SUB_ADMIN].include?current_user.admin_type
      #@simple_cpanel_layout=true
      #render "cpanel/users/login"
      render file:"#{Rails.root}/public/999.html",layout:false
      return
    end
  end
  
  def require_user(options = {})
    return true if user_signed_in?
    format = options[:format] || :html
    format = format.to_s
    if params[:redirect_path] and params[:redirect_path]!=''
      redirect_path = params[:redirect_path]
    else
      redirect_path = request.path
    end
    login_url = "/login?redirect_to=#{redirect_path}"
    if format == "html"
      redirect_to login_url
      return false
    elsif format == "json"
      if current_user.blank?
        render :json => { :success => false, :msg => "你还没有登录。" }
        return false
      end
    elsif format == "text"
      # Ajax 调用的时候如果没有登录，那直接返回 nologin，前段自动处理
      if current_user.blank?
        render :text => "_nologin_" 
        return false
      end
    elsif format == "js"
      if current_user.blank?
        render :html => "<script>window.location.href = '#{login_url}';</script>"
        return false
      end
    end
    true
  end

  def require_user_json
    require_user(:format => :json)
  end

  def require_user_js
    require_user(:format => :js)
  end

  def require_user_text
    require_user(:format => :text)
  end
  
  def tag_options(options, escape = true)
    unless options.blank?
      attrs = []
      options.each_pair do |key, value|
        if BOOLEAN_ATTRIBUTES.include?(key)
          attrs << %(#{key}="#{key}") if value
        elsif !value.nil?
          final_value = value.is_a?(Array) ? value.join(" ") : value
          final_value = html_escape(final_value) if escape
          attrs << %(#{key}="#{final_value}")
        end
      end
      " #{attrs.sort * ' '}".html_safe unless attrs.empty?
    end
  end
  
  def tag(name, options = nil, open = false, escape = true)
    "<#{name}#{tag_options(options, escape) if options}#{open ? ">" : " />"}".html_safe
  end
  
  def simple_format(text, html_options={}, options={})
    text = ''.html_safe if text.nil?
    start_tag = tag('p', html_options, true)
    text.gsub!(/\r\n?/, "\n")                    # \r\n and \r -> \n
    text.gsub!(/\n\n+/, "</p><br />#{start_tag}")  # 2+ newline  -> paragraph
    text.gsub!(/([^\n]\n)(?=[^\n])/, '\1<br />') # 1 newline   -> br
    text.insert 0, start_tag
    text.html_safe.safe_concat("</p>")
  end

  #def authenticate_user!(force=false)
  #  warden.authenticate!(:scope => :user) if !devise_controller? || force
  #end
  #
  #
  
  def login_via_zhaopin
    src='http://my.kejian.tv/loginmgr/loginproc.asp'
    canshu = {loginname:params[:loginname],password:params[:password],'Validate'=>params[:Validate],int_count:params[:int_count],bkurl:params[:bkurl]}
    proxy_addr = '192.168.20.6'
    proxy_port = 3128
    url = URI.parse(src)
    req = Net::HTTP::Post.new(url.path)
    req.set_form_data(canshu)
    res = Net::HTTP::Proxy(proxy_addr,proxy_port).start(url.host, url.port) {|http| http.request(req) }
    case res
    when Net::HTTPSuccess, Net::HTTPRedirection
      redirect_to params[:bkurl]
    else
      redirect_to 'http://my.kejian.tv/loginmgr/login.asp'
    end
  end

  
  def suggest
    if current_user and !(current_user.followed_topic_ids.blank? and current_user.following_ids.blank?)
      elim = current_user.is_expert ? 3 : 2
      ulim = current_user.is_expert ? 0 : 1
      tlim = 2
      e,u,t = UserSuggestItem.find_by_user(current_user)
      @suggested_experts = e.blank? ? [] :  User.any_in(:_id=>e.random(elim)).not_in(:_id=>current_user.following_ids)
      @suggested_users = u.blank? ?  [] :  User.any_in(:_id=>u.random(ulim)).not_in(:_id=>current_user.following_ids)
      @suggested_topics = t.blank? ? [] : Topic.any_in(:name=>t.random(tlim))
    end
  end
  
  def bson_invalid_object_id(e)
    raise 'todo'
    # redirect_to root_path, alert: "Resource not found."
  end

  def json_parse_error(e)
    raise 'todo'
    # redirect_to root_path, alert: "Json not valid"
  end

  def mongoid_errors_invalid_type(e)
    raise 'todo'
    # redirect_to root_path, alert: "Json values is not an array"
  end
  
  def pagination_get_ready
    params[:page] ||= 1
    params[:per_page] ||= 30
    @page = params[:page].to_i
    @per_page = params[:per_page].to_i
  end
  def pagination_over(sumcount)
    @page_count = (sumcount*1.0 / @per_page).ceil
  end
  
  def user_logged_in_required
    @seo[:title] = '请获取邀请以注册'
    @application_ie_noheader = true
    @application_ie_user_logged_in_required = true
    render 'user_logged_in_required',:layout => 'application_ie'
  end
  def modern_required
    @seo[:title] = '请使用更高版本的浏览器'
    @application_ie_noheader = true
    @application_ie_modern_required = true
    render 'modern_required',:layout => 'application_ie'
  end
  def sign_out_others
    cookies.each do |k,v|
      if k.starts_with?('WkpF_')
        cookies.delete(k, 'domain' => (Rails.env.development? ?  ".kejian.lvh.me" : ".kejian.tv"))
      end
    end
  end
end
