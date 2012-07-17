# coding: utf-8
class Courseware
  include Mongoid::Document
  include Mongoid::Timestamps
  include Redis::Search
  include BaseModel
  def self.human_attribute_name(attr, options = {})
    case attr.to_sym
    when :user;'课件的作者'
    when :slides_count;'幻灯片片数'
    when :course;'课件所属课程'
    when :courseware_series;'课件所属课件系列'
    when :title;'课件标题'
    when :title_en;'课件英文标题'
    when :title_pinyin;'课件拼音标题'
    when :desc;'课件描述'
    when :title_series_concerned;'标题(长)'
    when :sort1;'课件角色类型'
    when :sort2;'课件文件类型'
    when :sort_humanized;'课件类型'
    when :slug;'课件的友好资源标识号'
    when :course_slug;'所属课程的的友好资源标识号'
    when :course_name;'所属课程的的名字'
    when :xunlei_link;'迅雷播放特权地址'
    when :fallback_playback_link;'视频后援地址'
    when :link_memo;'链接备注'
    else
      COMMON_HUMAN_ATTR_NAME[attr].present? ? COMMON_HUMAN_ATTR_NAME[attr] : attr.to_s
    end
  end
  STATE_SYM = {
    0 => :normal,
    1 => :waiting4downloading,
    2 => :waiting4transcoding,
  }
  STATE_TEXT = {
    :normal => '已上线',
    :waiting4downloading => '正在读取文件',
    :waiting4transcoding => '正在转码',
  }
  
  SORTSTR = {
    'xunlei' => '迅雷播放特权',
    'ppt' => '幻灯片',
    'pdf' => 'PDF',
    'webm'=> '原创视频',
    'doc' => 'Word文档',
    'books' => '课本封皮'
  }
  
  field :status
  field :uploader_id
  
  field :course_long_name
  
  field :school_name
  field :school_id
  field :user_name
  field :user_id
  field :topic
  field :topic_id
  
  field :title
  field :title_en
  field :sort
  field :pdf_filename
  field :remote_filepath
  field :pinpicname
  field :pdf_size_note
  field :pdf_slide_processed
  field :down_pdf_size
  field :desc
  field :slug
  field :topic
  field :real_width, :type => Integer, :default => 0
  field :real_height, :type => Integer, :default => 0
  field :width, :type => Integer, :default => 0
  field :height, :type => Integer, :default => 0
  field :slides_count, :type => Integer, :default => 0
  field :thanks_count, :type => Integer, :default => 0
  field :comments_count, :type => Integer, :default => 0
  field :views_count, :type => Integer, :default => 0
  #-=xunlei=-
  field :xunlei_url
  belongs_to :user
  index :user_id
  before_validation :titleize
  def analyse2(two)
    if two
      the_rest = two.dup
      delim = ':'
      rests = the_rest.split(delim)
      if 1 == rests.size
        delim = '：'
        rests = the_rest.split(delim)
      end
      if 1 == rests.size
        self.user_name = self.uploader.name
        self.topic = self.course_long_name.strip
      else
        self.user_name = rests[0].strip
        self.topic = rests[1..-1].join(delim).strip
      end
  
      if self.school_name.present?
        self.course_long_name = "[#{self.school_name}] #{self.user_name}: #{self.topic}"
      else
        self.course_long_name = "#{self.topic}"
      end
    end
    
  end
  def titleize
    if self.course_long_name.present? and self.course_long_name_changed?
      self.course_long_name.strip!
      if self.course_long_name =~ /^\[([^\[\]]+)\](.*)$/
        self.school_name = $1.strip
        self.analyse2($2)
      elsif self.course_long_name =~ /^【([^【】]+)】(.*)$/
        self.school_name = $1.strip
        self.analyse2($2)
      else
        self.school_name = nil
        self.topic = self.course_long_name.strip
      end
      if self.topic.blank?
        self.topic = '课程请求'
      end
    end
  end
  def uploader
    User.find(self.uploader_id)
  end
  def topic_inst
    return nil if self.topic_id.blank?
    Topic.where(:_id => self.topic_id).first
  end
  def school
    return nil if self.school_id.blank?
    School.where(:_id => self.school_id).first
  end
  def user
    return nil if self.user_id.blank?
    User.where(:_id => self.user_id).first
  end
  before_save :create_stuff!
  def create_stuff!
    if self.course_long_name_changed?
      if self.school_name.present?
        school = School.find_or_create_by(:name => self.school_name)
        user = User.find_or_initialize_by(:school_id => school.id, :name => self.user_name)
        user.email_unknown = true if user.new_record?
        user.save(:validate => false)
        self.school_id = school.id
        self.user_id = user.id
      else
        self.user_id = self.uploader_id
      end
      topic = Topic.find_or_create_by(:name => self.topic)
      self.topic_id = topic.id
    end
  end
  
  scope :normal, where(:status => 0)
  scope :waiting4downloading, where(:status => 1)
  scope :waiting4transcoding, where(:status => 2)
  
  def state
    if 0==self.status
      {:name => STATE_TEXT[:normal],:css => :ok}
    elsif 1==self.status
      {:name => STATE_TEXT[:waiting4downloading],:css => :error}
    elsif 2==self.status
      {:name => STATE_TEXT[:waiting4transcoding],:css => :orange}
    else
      {:name => '奇异状态',:css => :error}
    end
  end
  
  def wh_ratio
    self.width*1.0/self.height
  end
  def thin?
    return true if self.width.present? and self.height.present? and self.width < self.height
    return false
  end
  def slide_width
    return 960 if self.thin?
    return 1024
  end
  def go_to_normal
    self.update_attribute(:status,0)
    # insert_courseware_action_log('GONE_NORMAL')
  end
  def img_path
    "cw/#{self.id}/thumb_slide_0.png"
  end
  def pinpic
    "cw/#{self.id}/#{self.pinpicname}"
  end
  def normal?
    0==self.status
  end
  validates_inclusion_of :sort,:in=>SORTSTR.keys
  
  # redis_search_index(:title_field => :title,:ext_fields => [:topics,:answers_count,:created_at], :score_field => :views_count)
end
