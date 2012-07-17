# coding: utf-8
require 'net/http'
require 'cryptor'
class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongo::Voter
  include Redis::Search
  include BaseModel
  has_many :coursewares
  before_validation :fill_in_unknown_email
  before_validation :fill_in_unknown_name
  def fill_in_unknown_email
    if self.email_unknown
      self.email_unknown = true
      self.email = "unknown#{Time.now.to_i}#{rand}@example.com"
    else
      self.email_unknown = false
    end
    true
  end
  def fill_in_unknown_name
    if self.name_unknown
      self.name_unknown = true
      self.name = "姓名请求"
    else
      self.name_unknown = false
    end
    true
  end
  before_validation :english_nameize
  def english_nameize
    if new_record? or name_changed?
      if self.name.present? and !self.name_unknown and self.name_en.blank?
        str = Pinyin.t(self.name,' ').titleize
        strs = str.split(' ')
        family_name = strs.shift
        given_name = strs.join('').downcase.camelize
        self.name_en = "#{given_name} #{family_name}"
      end
    end
  end
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :confirmable,
         :lockable, :timeoutable, :omniauthable, :invitable
  # P.S.V.R性能改善点，去掉validatable，防止['users'].find({:email=>"efafwfdlkjfdlsjl@qq.com"}).limit(-1).sort([[:_id, :asc]])查询
  ## Database authenticatable
  field :email,              :type => String, :null => false, :default => ""
  index :email, :uniq => true
  field :encrypted_password, :type => String, :null => false, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  field :confirmation_token,   :type => String
  field :confirmed_at,         :type => Time
  field :confirmation_sent_at, :type => Time
  field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  field :locked_at,       :type => Time

  ## Token authenticatable
  field :authentication_token, :type => String
  
  @before_soft_delete = proc{
    redis_search_index_destroy
    $redis_users.hdel self.id,:name
    $redis_users.hdel self.id,:slug
    $redis_users.hdel self.id,:avatar_filename
    $redis_experts.hdel self.id,:is_expert_why
  }
  @after_soft_delete = proc{
    self.update_attribute(:banished,"1")
    self.update_attribute(:user_type,User::BAN_USER)
  }
  def asynchronously_clean_me
    bad_ids = [self.id]
    Util.bad_id_out_of!(AskInvite,:invitor_ids,bad_ids)
    Util.bad_id_out_of!(Topic,:follower_ids,bad_ids)
    Util.bad_id_out_of!(Ask,:spam_voter_ids,bad_ids)
    Util.bad_id_out_of!(Ask,:to_user_ids,bad_ids)
    Util.bad_id_out_of!(Ask,:follower_ids,bad_ids)
    Util.bad_id_out_of!(User,:follower_ids,bad_ids)
    Util.bad_id_out_of!(User,:following_ids,bad_ids)
    Util.del_propogate_to(Comment,:user_id,bad_ids)
    Util.del_propogate_to(AskInvite,:user_id,bad_ids)
    Util.del_propogate_to(Notification,:user_id,bad_ids)
    Util.del_propogate_to(Answer,:user_id,bad_ids)
    Util.del_propogate_to(Ask,:to_user_id,bad_ids)
    Util.del_propogate_to(Ask,:user_id,bad_ids)
    # vote_up_count
    Answer.where("votes.up"=>self.id).each do |ans|
      ans.votes['up'].delete self.id
      ans.save
      ans.inc(:vote_up_count,-1)
    end
    Answer.where("votes.down"=>self.id).each do |ans|
      ans.votes['down'].delete self.id
      ans.save
      ans.inc(:vote_down_count,-1)
    end
    Deferred.where(:user_id=>self.id).each do |d|
      d.delete
    end
    # vote_down_count
    self.logs.each do |c|
      Notification.where(:log_id=>c._id).each do |n|
        n.update_attribute(:deleted,1)
      end
      c.delete
    end
    self.update_attribute(:banished,"1")
    # ------------------------
    self.followers.each{|u| u.inc(:following_count,-1)}
    self.following.each{|u| u.inc(:followers_count,-1)}
    self.thanked_answers.each{|an| an.inc(:thanked_count,-1)}
    self.followed_asks.each{|ask| ask.inc(:followed_count,-1)}
  end
  #user_type
  NORMAL_USER=1
  EXPERT_USER=2
  ELITE_USER=3
  FROZEN_USER=4
  BAN_USER=5
  USER_TYPE={User::NORMAL_USER=>"普通用户",User::EXPERT_USER=>"问道专家",User::ELITE_USER=>"问道精英",User::FROZEN_USER=>"冻结用户",User::BAN_USER=>"屏蔽用户"}
  #admin_type
  NO_ADMIN=1
  SUP_ADMIN=2
  SUB_ADMIN=3
  ADMIN_TYPE={User::NO_ADMIN=>"",User::SUP_ADMIN=>"管理员",User::SUB_ADMIN=>"副管理员"}
  has_many :oauth_accesses
  # the way to set admins:
  #   user.update_attribute(:admin_type,User::SUP_ADMIN)
  def self.admins
    User.where(:user_type.in=>[User::SUB_ADMIN,User::SUP_ADMIN])
  end
  def admin?
    self.admin_type==User::SUB_ADMIN or self.admin_type==User::SUP_ADMIN
  end
  def uri
    "http://#{Setting.domain}/users/#{self.slug}"
  end
  def self.human_attribute_name(attr, options = {})
    case attr.to_sym
    when :tagline
      '一句话介绍'
    when :slug
      '个性域名'
    when :inviting;'立即发送邀请'
    when :website;'个人网站'
    when :location;'地理位置'
    when :company;'公司'
    when :available_for_hire;'是否接受雇主联系'
    when :bio;'个人简介'
    when :department;'用户所属院系'
    when :school;'用户所属学校'
    when :email_human;'电子邮箱'
    when :slug;'用户的个性域名'
    when :password;'密码'
    when :password_confirmation;'密码确认'
    when :remember_me;'记住我的登录状态'
    when :name;'真实姓名'
    when :encrypted_password;'加密后密码'
    when :reset_password_token;'重置密码链接字符串'
    when :reset_password_sent_at;'重置密码链接字符串发送时间'
    when :remember_created_at;'记住我的登录状态创建时间'
    when :sign_in_count;'累计登录次数'
    when :current_sign_in_at;'本次登录于时间'
    when :last_sign_in_at;'上次登录时间'
    when :current_sign_in_ip;'本次登录IP'
    when :last_sign_in_ip;'上次登录IP'
    when :confirmation_token;'验证链接字符串'
    when :confirmed_at;'验证于时间'
    when :confirmation_sent_at;'验证链接发送于时间'
    when :unconfirmed_email;'待验证电子邮箱'
    when :failed_attempts;'失败登录尝试次数'
    when :unlock_token;'解锁链接字符串'
    when :locked_at;'锁定于时间'
    when :authentication_token;'认证字符串'
    when :email_unknown;'是否邮箱请求'
    when :name_unknown;'是否姓名请求'
    when :coursewares_count;'发布课件数'
    when :courseware_series_count;'发布课件系列数'
    when :hits_count;'资料被阅数'
    when :name_en;'英文名'
    when :avatar;'头像'
    when :tagline;'一句话简介'
    when :autotagline;'自动一句话简介'
    when :name_pinyin;'姓名拼音'
    when :thanks_count;'被感谢次数'
    when :banished;'是否被禁'
    when :born_at;'生日'
    when :died_at;'卒于'
    else
      COMMON_HUMAN_ATTR_NAME[attr].present? ? COMMON_HUMAN_ATTR_NAME[attr] : attr.to_s
    end
  end
  
  has_many :clients
  has_many :tokens, :class_name => "OauthToken"#, :order => "authorized_at desc", :include => [:client_application]
  field :current_mails
  
  field :zhaopin_ud
  field :is_expert, :type=>Boolean, :default=>false
  field :is_jingying, :type=>Boolean, :default=>false
  field :is_zombie, :type=>Boolean, :default=>false
  field :user_type, :type => Integer, :default => User::NORMAL_USER
  field :admin_type, :type => Integer, :default => User::NO_ADMIN
  field :admin_area, :type => Array, :default => []
  field :created_from_mobile, :type => Integer, :default=>0
  field :is_expert_why
  field :is_jingying_why
  field :name
  field :slug
  field :tagline
  field :tagline_changed_at
  field :avatar_changed_at, :type => Time
  field :last_login_at, :type => Time
  field :login_times, :type => Integer, :default => 0
  field :will_autofollow,:type=>Boolean,:default=>false
  field :bio
  field :location
  field :email_unknown,:type=>Boolean,:default=>false
  field :name_unknown,:type=>Boolean,:default=>false
  field :name_pinyin
  field :name_en
  field :school_id
  field :department
  field :died_at, :type => Date
  belongs_to :school

  before_save :autotagline_schoolize
  def autotagline_schoolize
    if new_record? or school_id_changed? or department_changed?
      self.tagline = ""
      self.tagline += self.school.name if self.school.present?
      self.tagline += self.department if self.department.present?
    end
  end
  before_save Proc.new{
    if self.tagline_changed?
      self.tagline_changed_at = Time.now
    end
  }
  before_save :downcase_email
  def downcase_email
    self.email.downcase!
  end
  before_save :counter_work
  def counter_work
    self.followers_count = self.follower_ids.count if self.follower_ids
    self.following_count = self.following_ids.count if self.following_ids
    if new_record?
    end
  end
  
  def state
    if self.name_unknown
      {:name => STATE_TEXT[:name_unknown],:css => :error}
    elsif self.banished
      {:name => STATE_TEXT[:banished],:css => :nothing}
    elsif !!self.died_at
      {:name => STATE_TEXT[:dead],:css => :nothing}
    elsif self.email_unknown
      {:name => STATE_TEXT[:email_unknown],:css => :warn}
    elsif !self.confirmed?
      {:name => STATE_TEXT[:nonconfirmed],:css => :black_white}
    else #if self.valid?
      {:name => STATE_TEXT[:normal],:css => :ok}
    # else
    #   {:name => '奇异状态',:css => :error}
    end
  end
  STATE_TEXT = {
    :name_unknown => '姓名请求',
    :email_unknown => '邮箱请求',
    :nonconfirmed => '等待邮件确认',
    :banished => '已被禁',
    :dead => '已过世',
    :normal => '正常'
  }
  # 是否允许登陆
  def active_for_authentication?
    self.encrypted_password.present? && '0'==self.banished && !access_locked? && died_at.blank? && confirmed?
  end
  scope :name_unknown, where(:name_unknown => true)
  scope :email_unknown, where(:email_unknown => true)
  scope :nonconfirmed, where(:confirmed_at => nil)
  scope :dead, where('died_at != NULL')
  scope :banished, where(:banished => '1')
  # validations----------------------------------------------------------------------
  validate :vali_name_check, :if => :name_required?
  def vali_name_check
    if self.name.blank?
      errors.add(:name,"不能为空字符")
      return false      
    end
    unless self.name.starts_with?('_')
      if Ktv::Utils.js_strlen(self.name)>12
       errors.add(:name,"不能多于6个汉字或者12个字符")
       return false
      end
      if Ktv::Utils.js_chinese(self.name)<2
       errors.add(:name,"并非真实中文姓名")
       return false
      end
      if !Ktv::Renren.name_okay?(self.name)
       errors.add(:name,"不是合法的中文姓名<br><span style=\"font-size:12px\">(若不愿透露姓名，请输入一个下划线开头的名字以跳过此测试)</span>")
       return false
      end
    end
  end
  validate :bio_lengthvali
  def bio_lengthvali
    errors.add(:bio, '太长') unless Nokogiri.HTML(self.bio).text().length() <= 4000
  end
  validates_length_of :tagline,:maximum=>40
  validates_presence_of :name, :slug
  validates_uniqueness_of :slug,:message=>'与已有个性域名重复，请尝试其他域名'
  validates_format_of :slug, :with => /[a-z0-9\-\_]{1,20}/i
  validate :name_change_not_too_often
  # 用户修改昵称，一个月只能修改一次
  def name_change_not_too_often
    unless self.new_record?
      if self.name_changed?
        if self.name_last_changed_at and self.name_last_changed_at > 1.months.ago
          errors[:base] << "对不起，真实姓名一个月只能修改一次"
          return false
        else
          self.name_last_changed_at = Time.now
          return true
        end
      end
    end
  end
  attr_accessor :during_registration,:force_confirmation_instructions,:inviting
  alias_method :send_on_create_confirmation_instructions_before_psvr,:send_on_create_confirmation_instructions
  alias_method :send_confirmation_instructions_before_psvr,:send_confirmation_instructions
  def send_on_create_confirmation_instructions
    unless self.email_unknown or self.name_unknown
      if self.inviting or self.during_registration or self.force_confirmation_instructions
        send_on_create_confirmation_instructions_before_psvr
      end
    end
  end
  def send_confirmation_instructions
    unless self.email_unknown or self.name_unknown
      send_confirmation_instructions_before_psvr
    end
  end
  def password_required?
    return true if self.during_registration
    return false
  end
  def name_required?
    !self.name_unknown
  end
  # ----------------------------------------------------------------------------------
  
  
  field :avatar
  field :website
  # 是否是女人
  field :girl, :type => Boolean, :default => false

  # 是否是可信用户，可信用户有更多修改权限
  field :credible, :type => Boolean, :default => false

  # 不感兴趣的问题
  field :muted_ask_ids, :type => Array, :default => []
  field :muted_expert_ids, :type => Array, :default => []
  field :muted_user_ids, :type => Array, :default => []
  field :muted_topics, :type => Array, :default => []
  # 关注的问题
  field :followed_ask_ids, :type => Array, :default => []
  # 回答过的问题
  field :answered_ask_ids, :type => Array, :default => []
  # Email 提醒的状态
  field :mail_be_followed, :type => Boolean, :default => true
  field :mail_new_answer, :type => Boolean, :default => true
  field :mail_invite_to_ask, :type => Boolean, :default => true
  field :mail_ask_me, :type => Boolean, :default => true
  field :thanked_answer_ids, :type => Array, :default => []
  def thanked_answers
    Answer.where(:_id.in=>self.thanked_answer_ids)
  end
  # 邀请字段
  field :invitation_token
  field :invitation_sent_at, :type => Time


  has_many :asks
  has_many :comments
  
  field :asks_count, :type => Integer, :default => 0  
  field :answers_count, :type => Integer, :default => 0
  field :comments_count, :type => Integer, :default => 0
  field :followers_count, :type => Integer, :default => 0
  field :following_count, :type => Integer, :default => 0
  field :vote_up_count, :type => Integer, :default => 0
  field :vote_down_count, :type => Integer, :default => 0
  field :share_count, :type => Integer, :default => 0
  field :invite_count, :type => Integer, :default => 0
  field :invited_count, :type => Integer, :default => 0
  field :thank_count, :type => Integer, :default => 0
  field :thanked_count, :type => Integer, :default => 0
  field :coursewares_count, :type => Integer, :default => 0
  field :upload_count, :type => Integer, :default => 0
  has_many :answers
  has_many :notifications
  has_many :inboxes
  field :banished

  def following_names
    self.following_ids.collect{|id| User.find(id).name}
  end

  index :created_at
  index :is_expert
  index :followed_ask_ids
  index :followed_topic_ids
  index :slug, :uniq => true
  index :follower_ids
  index :following_ids
  index :name
  index :tags
  index :asks_count
  index :answers_count
  index :comments_count
  index :followers_count
  index :login_times
  index :last_login_at
  index :avatar_changed_at
  index :avatar_filename

  references_and_referenced_in_many :followed_asks, :inverse_of => :followers, :class_name => "Ask"
  references_and_referenced_in_many :followed_topics, :inverse_of => :followers, :class_name => "Topic"
  
  references_and_referenced_in_many :following, :class_name => 'User', :inverse_of => :followers, :index => true
  references_and_referenced_in_many :followers, :class_name => 'User', :inverse_of => :following, :index => true

  # field :followed_ask_ids, :type => Array, :default => []
  # field :followed_topic_ids, :type => Array, :default => []
  # field :following_ids, :type => Array, :default => []
  # field :follower_ids, :type => Array, :default => []
  
  embeds_many :authorizations
  has_many :logs, :class_name => "Log", :foreign_key => "target_id",dependent: :destroy

  attr_accessor  :password_confirmation
  # attr_accessor :tags_array
  def tags_array=(str)
    self.tags = str.split(',').collect{|str|str.strip}
  end
  
  def tags_array
    if self.tags
      self.tags.join(',')
    else
      ''
    end
  end
  def avatar_filename
    ret = self.avatar.to_s
    if ret
      ret.split('/')[-1]
    else
      gravatar_id = Digest::MD5.hexdigest(self.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png"
    end
  end
  field :tags
  field :name_last_changed_at
  
  # 以下两个方法是给 redis search index 用

  def avatar_small
    self.avatar.small.url
  end
  def avatar_small38
    self.avatar.small38.url
  end

  def avatar_small_changed?
    self.avatar_changed?
  end

  # 用户评分，暂时方案
  def score
    self.answers_count + self.follower_ids.count * 2
  end
  def score_changed?
    self.answers_count_changed?
  end
  
  redis_search_index(:title_field => :name2,
    :prefix_index_enable => false,
    :ext_fields => [:id, :slug,:avatar_small38,:tagline, :score, :followers_count, :answers_count, :search_score],
    :score_field => :search_score)
  def name2
    "#{self.name}@@#{self.tagline}"
  end
  def name2_changed?
    self.name_changed? or self.tagline_changed?
  end
  def name2_was
    "#{self.name_was}@@#{self.tagline_was}"
  end
  

  def zancheng_piaoshu
    self.answers.inject(0) do |memo,obj|
      num = obj.votes['up_count']
      if num.nil?
        memo
      else
        memo + num
      end
    end
  end
  
  def search_score
    if self.is_expert
      ret = 10000
    elsif self.is_jingying
      ret = 5000
    else
      ret = 0
    end
    ret += [80, answers_count].min * zancheng_piaoshu
    ret
  end
  # after_validation Proc.new{
  #   if(user = User.where(email:'angela.cai@zhaopin.com.cn').first)
  #     self.following_ids << user.id
  #     user.follower_ids << self.id
  #   end
  # }
  # after_create Proc.new{
  #   User.where(:will_autofollow=>true).each{ |user|
  #     self.follow(user,true)
  #   }
  #   Topic.where(:will_autofollow=>true).each{ |topic|
  #     self.follow_topic(topic,true)
  #   }
  #   Ask.where(:will_autofollow=>true).each{ |ask|
  #     self.follow_ask(ask,true)
  #   }
  # }
  before_validation :check_spam_words
  def check_spam_words
    if self.spam?("tagline")
      return false
    end
    if self.spam?("name")
      return false
    end
    if self.spam?("slug")
      return false
    end
    if self.spam?("bio")
      return false
    end
  end



  def self.find_for_authentication(conditions) 
    conditions[:email].try(:downcase!)
    super
  end

  def self.find_or_initialize_with_errors(required_attributes, attributes, error=:invalid)
    attributes[:email].try(:downcase!)
    super
  end


  
  mount_uploader :avatar, AvatarUploader

  def self.create_from_hash(auth)  
		user = User.new
		user.name = auth["user_info"]["name"]  
		user.email = auth['user_info']['email']
    if user.email.blank?
      user.errors.add("Email","三方网站没有提供你的Email信息，无法直接注册。")
      return user
    end
		user.save
		user
  end  

  before_validation :auto_slug
  # 此方法用于处理开始注册是自动生成 slug, 因为没表单,只能自动
  def auto_slug
    if self.slug.blank?
      if !self.email.blank?

        self.slug = self.email.split('@')[0]
        self.slug = self.slug.split('.').join('-')
        self.slug += Time.now.to_i.to_s if self.slug.length<1
        self.slug = self.slug[0..7] if self.slug.size>8

        self.slug = self.slug.safe_slug
      end
      # 如果 slug 被 safe_slug 后是空的,就用 id 代替
      if self.slug.blank?
        self.slug = self.id.to_s
      end
    else
      self.slug = self.slug.safe_slug
    end

    # 防止重复 slug
    old_user = User.find_by_slug(self.slug)
    if !old_user.blank? and old_user.id != self.id
      self.slug = self.id.to_s
    end
  end

  def auths
    self.authorizations.collect { |a| a.provider }
  end

  def self.find_by_slug(slug)
    where({:slug => slug}).first
  end

  # 不感兴趣问题
  def ask_muted?(ask_id)
    self.muted_ask_ids.include?(ask_id)
  end
  
  def ask_followed?(ask)
    return false if ask.blank?
    if ask.respond_to?(:id)
      self.followed_ask_ids.include?(ask.id)
    else
      self.followed_ask_ids.include?(ask)
    end
  end
  
  def followed?(user)
    return false if user.blank?
    if user.respond_to?(:id)
      self.following_ids.include?(user.id)
    else
      self.following_ids.include?(user)
    end
  end
  
  def topic_followed?(topic)
    return false if topic.blank?
    if topic.respond_to?(:id)
      self.followed_topic_ids.include?(topic.id)
    else
      self.followed_topic_ids.include?(topic) or self.followed_topic_ids.map{|x|x.to_s}.include?(Topic.get_id(topic))
    end
  end
  
  def mute_ask(ask_id)
    self.muted_ask_ids ||= []
    return if self.muted_ask_ids.index(ask_id)
    self.muted_ask_ids << ask_id
    self.save
  end
  
  def unmute_ask(ask_id)
    self.muted_ask_ids.delete(ask_id)
    self.save
  end
  
  def follow_ask(ask,nolog=false)
    return if self.followed_ask_ids.include? ask.id
    self.followed_ask_ids << ask.id
    self.save
    ask.follower_ids << self.id
    ask.followed_count = ask.follower_ids.count
    ask.save
    
    insert_follow_log("FOLLOW_ASK", ask) unless nolog
  end
  def follow_asks(asks,nolog=false)
    asks.each do |t|
      follow_ask(t,nolog)
    end
  end
  
  def unfollow_ask(ask,nolog=false)
    self.followed_ask_ids.delete(ask.id)
    self.save
    
    ask.follower_ids.delete(self.id)
    ask.followed_count = ask.follower_ids.count
    ask.save
    
    insert_follow_log("UNFOLLOW_ASK", ask) unless nolog
  end
  
  def follow_topic(topic,nolog=false)
    if topic.respond_to?(:id)
      topicid=topic.id
    else
      topicid=topic
    end
    return if self.followed_topic_ids.include? topicid
    if self.is_expert
      self.tags||=[]
      self.tags << topic.name unless self.tags.include?(topic.name)
    end
    self.followed_topic_ids << topicid
    self.save
    topic.follower_ids << self.id
    topic.followers_count_changed = true
    topic.save

    # 清除推荐话题
    # UserSuggestItem.delete(self.id, "Topic", topic.id)
    
    insert_follow_log("FOLLOW_TOPIC", topic) unless nolog
    topic.redis_search_index_create
  end
  def follow_topics(topics,nolog=false)
    topics.each do |t|
      follow_topic(t,nolog)
    end
  end
  
  
  def unfollow_topic(topic,withlog=true)
    self.followed_topic_ids.delete(topic.id)
    self.save
    
    topic.follower_ids.delete(self.id)
    topic.followers_count_changed = true
    topic.save
    
    insert_follow_log("UNFOLLOW_TOPIC", topic) if withlog
    
    topic.redis_search_index_create
  end

  def msg_center_action_follow(user_ud)
    send_to_msg_center({
      "SourceId"=>"",
      "MsgType"=>30,
      "MsgSubType"=>3020,
      "Receiver"=>user_ud,
      "Sender"=>"#{self.name}",
      "SenderUrl"=>"http://wendao.zhaopin.com/users/#{self.slug}",
      "SendContent"=>"<P><a href=\"http://wendao.zhaopin.com/users/#{self.slug}\">#{self.name}</a>关注了你。</P>",
      "SendContentUrl"=>"",
      "OperateUrl"=>""
  	})
  end
  def follow(user,nolog=false)
    if user.respond_to?(:each)
      user.each do |u|
        self.follow(u,nolog)
      end
    else
      return if self.following_ids.include? user.id
      self.following_ids << user.id
      self.following_count = self.following_ids.count
      self.save
      user.follower_ids << self.id
      user.followers_count = user.follower_ids.count
      user.save

      # 清除推荐话题
      # UserSuggestItem.delete(self.id, "User", user.id)

      # 发送被 Follow 的邮件
      UserMailer.deliver_delayed(UserMailer.be_followed(user.id,self.id)) unless nolog

      insert_follow_log("FOLLOW_USER", user) unless nolog
      Resque.enqueue(HookerJob,self.class.to_s,self.id,:msg_center_action_follow,user.zhaopin_ud)
      self.redis_search_index_create
      user.redis_search_index_create
    end
    
  end
  def msg_center_action_vote(userb_id,c_id)
    usera = self
    userb = User.find(userb_id)
    ask = Ask.find(c_id)
    send_to_msg_center({
      "SourceId"=>"",
      "MsgType"=>30,
      "MsgSubType"=>3040,
      "Receiver"=>userb.zhaopin_ud,
      "Sender"=>"#{usera.name}",
      "SenderUrl"=>"http://wendao.zhaopin.com/users/#{usera.slug}",
      "SendContent"=>"<P><a href=\"http://wendao.zhaopin.com/users/#{usera.slug}\">#{usera.name}</a>赞同了你的回答“<a href=\"http://wendao.zhaopin.com/asks/#{ask.id}\">#{ask.title}</a>”。</P>",
      "SendContentUrl"=>"",
      "OperateUrl"=>""
  	})    
  end
  
  def unfollow(user,nolog=false)
    self.following_ids.delete(user.id)
    self.following_count = self.following_ids.count
    self.save
    
    user.follower_ids.delete(self.id)
    user.followers_count = user.follower_ids.count
    user.save
    
    insert_follow_log("UNFOLLOW_USER", user) unless nolog

    self.redis_search_index_create
    user.redis_search_index_create
  end

  # 感谢回答
  def thank_answer(answer)
    self.thanked_answer_ids ||= []
    return true if self.thanked_answer_ids.index(answer.id)
    self.thanked_answer_ids << answer.id
    self.save
    insert_follow_log("THANK_ANSWER", answer, answer.ask)
  end

  # 软删除
  # 只是把用户信息修改了
  def soft_delete(async=false)
    self.update_attribute(:name,"#{self.name.gsub('[已注销]','')}[已注销]")
    self.update_attribute(:slug,"#{self.id}")
    
    super(async)
  end
  
  #添加后台删除操作记录
  def info_delete(user_id)
    Resque.enqueue(HookerJob,self.class.to_s,self.id,:async_info_delete,user_id)
  end
  def async_info_delete(user_id)
    self.asks.each do |a|
      a.update_attribute(:deletor_id,BSON::ObjectId(user_id))
      a.update_attribute(:deleted_at,Time.now)
    end
    self.answers.each do |a|
      a.update_attribute(:deletor_id,BSON::ObjectId(user_id))
      a.update_attribute(:deleted_at,Time.now)
    end
    self.comments.each do |c|
      c.update_attribute(:deletor_id,BSON::ObjectId(user_id))
      c.update_attribute(:deleted_at,Time.now)
    end
  end
  #提问的疑似广告检验与处理
  def ask_advertise(ask_id)
    range=SettingItem.where(:key=>"ask_advertise_limit_time_range").first.value.to_i
    count=SettingItem.where(:key=>"ask_advertise_limit_count").first.value.to_i
    time=(a=Ask.where(:_id=>ask_id).first).blank? ? Time.now : a.created_at
    size=Ask.where(:user_id=>self.id,:created_at.gt=>time-range.minute,:created_at.lte=>time).count
    if size>count
      deal_range=SettingItem.where(:key=>"ask_advertise_limit_deal_range").first.value.to_i
      self.update_attribute(:user_type,User::FROZEN_USER)
      Ask.where(:user_id=>self.id,:created_at.gt=>time-deal_range.hour).each do |a|
        a.update_attribute(:deleted,3)
        a.redis_search_index_destroy
      end
    end
  end
  #回答的疑似广告检验与处理
  def answer_advertise(answer_id)
    range=SettingItem.where(:key=>"answer_advertise_limit_time_range").first.value.to_i
    count=SettingItem.where(:key=>"answer_advertise_limit_count").first.value.to_i
    time=(a=Answer.where(:_id=>answer_id).first).blank? ? Time.now : a.created_at
    size=Answer.where(:user_id=>self.id,:created_at.gt=>time-range.minute,:created_at.lte=>time).count
    if size>count
      deal_range=SettingItem.where(:key=>"answer_advertise_limit_deal_range").first.value.to_i
      self.update_attribute(:user_type,User::FROZEN_USER)
      Answer.where(:user_id=>self.id,:created_at.gt=>time-deal_range.hour).each do |a|
        a.update_attribute(:deleted,3)
      end
    end
  end
  #评论的疑似广告检验与处理
  def comment_advertise(comment_id)
    range=SettingItem.where(:key=>"answer_advertise_limit_time_range").first.value.to_i
    count=SettingItem.where(:key=>"answer_advertise_limit_count").first.value.to_i
    time=(c=Comment.where(:_id=>comment_id).first).blank? ? Time.now : c.created_at
    size=Comment.where(:user_id=>self.id,:created_at.gt=>time-range.minute,:created_at.lte=>time).count
    if size>count
      deal_range=SettingItem.where(:key=>"answer_advertise_limit_deal_range").first.value.to_i
      self.update_attribute(:user_type,User::FROZEN_USER)
      Comment.where(:user_id=>self.id,:created_at.gt=>time-deal_range.hour).each do |c|
        c.update_attribute(:deleted,3)
      end
    end
  end
  # 我的通知
  def unread_notifies
    notifies = {}
    notifications = self.notifications.nondeleted.unread.desc('created_at') #.includes(:log)
    notifications.each do |notify|
      notifies[notify.target_id] ||= {}
      notifies[notify.target_id][:items] ||= []
      
      case notify.action
      when "FOLLOW" then notifies[notify.target_id][:type] = "USER"
      when "THANK_ANSWER" then
        notifies[notify.target_id][:type] = "THANK_ANSWER"
      when "INVITE_TO_ANSWER" then notifies[notify.target_id][:type] = "INVITE_TO_ANSWER"
      when "NEW_TO_USER" then notifies[notify.target_id][:type] = "ASK_USER"
      else  
        notifies[notify.target_id][:type] = "ASK"
      end
      if "THANK_ANSWER"==notify.action
        if answer = Answer.find(notify.target_id)
          if ask=answer.ask
            notifies[ask.id]||={}
            notifies[ask.id][:items]||=[]
            notifies[ask.id][:items]<<notify
          end
        end
      else
        notifies[notify.target_id][:items] << notify
      end
    end
    
    [notifies, notifications]
  end

  # 推荐给我的人或者话题
  def suggest_items
    # return UserSuggestItem.gets(self.id, :limit => 6)
    topics = Topic.desc('hot_rank').collect{|x| [x.name,x.followers_count]}
    
    already = self.followed_topic_ids
    already ||= []
    already_names = already.collect{|id| if topic=Topic.where(_id:id).first;topic.name;else;nil;end}.compact
    topics = topics.delete_if{ |x| already_names.include?(x[0]) }
    topics = topics[0..2] if topics.size>3
    ret = []
    ret += topics.collect{|n|Topic.where(name:n[0]).first}
    ret += self.following.limit(2).to_a
    return ret
  end
  
  # 刷新推荐的人
  # def refresh_suggest_items
  #   related_people = self.followed_topics.inject([]) do |memo, topic|
  #     memo += topic.followers
  #   end.uniq
  #   related_people = related_people - self.following - [self] if related_people
  #   
  #   related_topics = self.following.inject([]) do |memo, person|
  #     memo += person.followed_topics
  #   end.uniq
  #   related_topics -= self.followed_topics if related_topics
  #   
  #   items = related_people + related_topics
  #   # 存入 Redis
  #   saved_count = 0
  #   # 先删除就的缓存
  #   UserSuggestItem.delete_all(self.id)
  #   mutes = UserSuggestItem.get_mutes(self.id)
  #   items.shuffle.each do |item|
  #     klass = item.class.to_s
  #     # 跳过 mute 的信息
  #     next if mutes.include?({"type" => klass, "id" => item.id.to_s})
  #     # 跳过删除的用户
  #     next if klass == "User" and item.deleted == 1
  #     usi = UserSuggestItem.new(:user_id => self.id, 
  #                               :type => klass,
  #                               :id => item.id)
  #     if usi.save
  #       saved_count += 1
  #     end
  #   end
  #   saved_count
  # end
  cache_consultant :name,:no_callbacks=>true
  cache_consultant :slug,:no_callbacks=>true
  cache_consultant :avatar_filename,:no_callbacks=>true
  cache_consultant :is_expert_why,:redis_varname=>'$redis_experts',:no_callbacks=>true

  after_create :update_consultant!
  def update_consultant!
    $redis_users.hset(self.id,:name,self.name)
    $redis_users.hset(self.id,:slug,self.slug)
    $redis_users.hset(self.id,:avatar_filename,self.avatar_filename)
    if self.is_expert
      $redis_experts.hset(self.id,:is_expert_why,self.is_expert_why)
    end
  end
  
  def already_jubao(url)
    name = self.name
    ReportSpam.where(:url => url).each do |item|
      item.descriptions.each do |desc|
        if desc.starts_with?(name)
          return true
        end
      end
    end
    return false
  end
  protected
  
  def insert_follow_log(action, item, parent_item = nil)
    begin

      if ["FOLLOW_TOPIC", "UNFOLLOW_TOPIC"].include?(action) and log = UserLog.where(:user_id=>self.id,:action=>action,:created_at.gt=>1.hours.ago).first          
        log.target_ids ||= []
        log.target_ids.delete(item.id)
        log.target_ids << item.id
        log.save
        return
      end

      log = UserLog.new
      log.user_id = self.id
      log.title = self.name
      log.target_id = item.id
      log.target_ids = [item.id]
      log.action = action
      if parent_item.blank?
        log.target_parent_id = item.id
        log.target_parent_title = item.is_a?(Ask) ? item.title : item.name
      else
        log.target_parent_id = parent_item.id
        log.target_parent_title = parent_item.title
      end
      log.diff = ""
      log.save

    rescue Exception => e
        
    end
  end

end
