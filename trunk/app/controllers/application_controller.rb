# coding: utf-8
require 'digest/md5'
require 'net/http'
require 'uri'
class ApplicationController < ActionController::Base
  has_mobile_fu
  protect_from_forgery
  before_filter proc{
    if params[:force_mobile] or is_mobile_device?
      $zhaopin_is_mobile_device = true
    else
      $zhaopin_is_mobile_device = false
    end
  }
  before_filter proc{
  }
  if Setting.error_tracker_enabled or 'production'==Rails.env
    rescue_from(Exception){|e|
      f = File.new(Rails.root+"log/error.log","a")
      str = "#{Time.now.getlocal}\n"
      str += "#{request.request_method} #{request.path}\n"
      str += "#{request.user_agent}\n"
      str += e.message+"\n"+e.backtrace.join("\n")
      str += "\n---------------------------------------------\n"
      f.print str
      f.close
=begin
      if Setting.error_tracker_enabled
        client = Savon::Client.new{wsdl.document=Setting.error_tracker_wsdl}
        client.request :wsdl,'add_error_log','wendao',,e.message
      end
=end
      if Setting.error_tracker_enabled
        first = CGI::escape("#{request.request_method}_#{request.path}".split('/').join('[]'))
        #second = CGI::escape("#{e.message}".split('/').join('[]'))
        second = CGI::escape(str)
        Resque.enqueue(ErrorTrackerJob,first,second)
      end
      render file:"errors/500.html.erb",layout:false
    }
  end

  helper :all
  before_filter :load_notice, :xookie
  before_filter Proc.new{
    # render text:request.subdomain and return
    # $redis.incr('stat1231')  if 'http://article.zhaopin.com/zt/2011/1231.html'==request.referer
  
  if user_signed_in?
    if current_user.banished.present? and (current_user.banished=="1" or current_user.banished==true)
      render file:'shared/banished' and return
    end
  end
  }
  before_filter Proc.new{
    params[:page]='0' if ''==params[:page]
  
  } 

  # before_filter :bao10jie_filter

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
  
  # Comet Server
  use_zomet
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
    keywords = options[:keywords] || "职业规划,问答,职场,加薪,问道,"
    description = options[:description] || "问道是智联招聘旗下的职场领域问答交流平台.问道助你制定专业的职业规划,提供求职指导,分享职场知识,赢取工作机会.问道拥有大批职场专家,行业资深人士,知名企业HR,同行,校友."

    if title.length > 0
      @page_title = "#{title} &raquo; "
    end
    @meta_keywords = keywords
    @meta_description = description
  end

  def render_404
    render_optional_error_file(404)
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
  
  def require_admin
    if current_user.blank?
      @simple_cpanel_layout=true
      render "cpanel/users/login"
      return
    end
    if ![User::SUP_ADMIN,User::SUB_ADMIN].include?current_user.admin_type
      @simple_cpanel_layout=true
      render "cpanel/users/login"
    end
  end
  
  def require_user(options = {})
    format = options[:format] || :html
    format = format.to_s
    if params[:redirect_path] and params[:redirect_path]!=''
      redirect_path = params[:redirect_path]
    else
      redirect_path = request.path
    end
    login_url = Setting.zhaopin_login+CGI::escape('http://'+Setting.wendao_domain_name+redirect_path)
    if format == "html"
      if current_user
        #Pan>
        # if some deprecated path is reqested
        # at this point, the user is already authenticated
        # so redirecting to index page
        if 'require_user'==params[:action] and 'application'==params[:controller]
          redirect_to 'http://'+Setting.wendao_domain_name+'/'
        end
      else
        redirect_to login_url
      end
      return false
      #authenticate_user!
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
    src='http://my.zhaopin.com/loginmgr/loginproc.asp'
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
      redirect_to 'http://my.zhaopin.com/loginmgr/login.asp'
    end
  end



  if 'test'==Rails.env
    def test_login
      session[:testuser__name]=params[:name]
      session[:testuser__email]=params[:email]
      session[:testuser__pass]=params[:password]
      redirect_to '/'
    end
    def test_logout
      session[:testuser__name]=nil
      session[:testuser__email]=nil
      session[:testuser__pass]=nil
      redirect_to '/'
    end
    def xookie
      email = session[:testuser__email]
      if email.blank?
        sign_out
      else
        u = User.where(email: email).first
        u ||= User.create!(name:session[:testuser__name],
          email:session[:testuser__email],
          password:session[:testuser__pass],
          password_confimation:session[:testuser__pass])
        sign_in(u)
      end
    end
  else
    def xookie
      # sign_in( User.where(slug:'a.b.c.d').first)
      sui = cookies["JSsUserInfo"]
      pui = cookies["JSpUserInfo"]
      u = User.authenticate_through_ui!(sui,cookies["JSShowname"],params[:force_mobile] || is_mobile_device?)
      u ||= User.authenticate_through_ui!(pui,cookies["JSShowname"],params[:force_mobile] || is_mobile_device?)
      if u
        if session[:wendaouser__email].blank? or session[:wendaouser__email]!=u.email
          u.update_attribute("last_login_at",Time.now)
          u.inc(:login_times,1)
          LoginLog.create(:user_id=>u.id,:login_at=>Time.now,:range=>(Time.now.to_date-u.created_at.to_date).to_i)
          session[:wendaouser__email]=u.email
        end
        sign_in(u)
        @current_user=u
      else
        session[:wendaouser__email]=nil
        sign_out
        @timenum=Time.now.to_i
      end
    end
  end
  
  protected
  def bao10jie_sig(canshu)
    canshu
    canshu_a  = canshu.sort
    pinjie = []
    canshu_a.each do |item|
      pinjie << "#{item[0]}=#{item[1]}"
    end
    pinjie = pinjie.join('&')
    pinjie+=Bao10jie::Config::APP_KEY
    Digest::MD5.hexdigest(pinjie)
  end

  def bao10jie_filter
    return true if request.method=='GET'
    url = URI.parse(Bao10jie::Config::PURIFY_API)
    proxy_addr = '192.168.20.6'
    proxy_port = 3128

    req = Net::HTTP::Post.new(url.path)
    bao10fied = params.inspect
    bao10fied = bao10fied.split(/<|>|<(\S*?)[^>]*>.*?<\\1>|<.*? \/> /).join('')
    xml = <<HERE
<?xml version="1.0" encoding="utf-8"?>
        <contents>
          <content>
            <class>11</class>
            <textId>324</textId>
            <url>http://www.sina.com/1.htm</url>
            <title>标题</title>
            <text><![CDATA[#{bao10fied}]]></text>
            <author>网名</author>
            <userId>xxxx</userId>
            <ip>0.0.0.0</ip>
            <pubDate>#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}</pubDate>
            <threadId>34553</threadId>
            <authorEx>扩展</authorEx>
            <contentEx>扩展</contentEx>
            <structureEx>扩展</structureEx>
            <rules></rules>
          </content>
        </contents>
HERE
    canshu = {
      'format'=>'JSON',
      'appid'=>Bao10jie::Config::APP_ID,
      'appType'=>Bao10jie::Config::APP_TYPE,
      'v'=>'2.0',
      'time'=>Time.now.to_i,
      'transId'=>Bao10jie::Config::TRANS_ID,
      'param'=>xml
    }
    canshu['sig']=bao10jie_sig(canshu)
    debug=''
=begin
    canshu.each do |key,value|
      canshu[key] = CGI::escape(value.to_s)
debug+="#{key}=>#{value}\n"
    end
=end
    req.set_form_data(canshu)
    #render text:req.body and return
    #res = Net::HTTP::Proxy(proxy_addr,proxy_port).start(url.host, url.port) {|http| http.request(req) }
    res = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }

    case res
    when Net::HTTPSuccess, Net::HTTPRedirection
      bao10result = JSON.parse(res.body)
      #Rails.logger.info bao10result.to_s
      #render text:bao10result and return
      bao10result = bao10result['purifyPredictResponse']['contents']['content']['clueClass']
      if bao10result and bao10result!='' and 'SensitiveServices'==bao10result
        render text:'您的请求含有敏感信息!' and return false
      else
        return true
      end
    else
      return true
      res.error!
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
  
end
