# coding: utf-8
class Courseware
  include Mongoid::Document
  include Mongoid::Timestamps
  include Redis::Search
  include BaseModel
  @before_soft_delete = proc{
    redis_search_index_destroy
  }
  def self.human_attribute_name(attr, options = {})
    case attr.to_sym
    when :user;'课件的作者'
    when :slides_count;'幻灯片片数'
    when :title;'课件标题'
    when :title_en;'课件英文标题'
    when :title_pinyin;'课件拼音标题'
    when :desc;'课件描述'
    when :title_series_concerned;'标题(长)'
    when :sort1;'课件角色类型'
    when :sort2;'课件文件类型'
    when :sort_humanized;'课件类型'
    when :slug;'课件的友好资源标识号'
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
    3 => :finalizing,
    -1 => :error,
  }
  STATE_TEXT = {
    :normal => '已上线',
    :waiting4downloading => '正在读取文件',
    :waiting4transcoding => '正在转码',
    :error => '您上传的文件已损坏',
    :finalizing => '正在完成最后的处理',
  }
  
  scope :normal, where(:status => 0)
  scope :waiting4downloading, where(:status => 1)
  scope :waiting4transcoding, where(:status => 2)
  scope :finalizing, where(:status => 3)
  
  SORTSTR = {
    'xunlei' => '迅雷播放特权',
    'ppt' => '幻灯片',
    'pptx' => '幻灯片',
    'doc' => '文档资料',
    'docx' => '文档资料',
    'pdf' => 'PDF',
    'djvu' => 'DJVU',
    'webm'=> '原创视频',
    'books' => '课本封皮'
  }
  def asynchronously_clean_me
    bad_ids = [self.id]
    self.user.inc(:coursewares_count,-1) if self.user
    self.uploader.inc(:upload_count,-1) if self.uploader
    Util.bad_id_out_of!(User,:thanked_courseware_ids,bad_ids)
    Util.del_propogate_to(Comment,:_id,self.comments.collect(&:id))
    thanked = false
    User.where(:thanked_courseware_ids=>self.id).each do |u|
      u.inc(:thank_coursewares_count,-1)
      thanked = true
    end
    self.user.inc(:thank_coursewares_count,-1) if thanked
    self.topic_inst.redis_search_index_create
  end
  field :tid

  field :md5
  field :status
  field :uploader_id
  field :is_thin,:type => Boolean,:default => true
  field :title_short
  
  field :school_name
  field :school_id
  field :user_name
  field :user_id
  field :topic
  field :topics
  field :topic_id
  
  field :title
  field :title_en
  field :sort
  field :pdf_filename
  field :remote_filepath
  field :pinpicname
  field :pdf_size_note
  field :pdf_slide_processed
  field :filesize
  field :down_pdf_size
  field :desc
  field :slug
  field :topic
  field :real_width, :type => Integer, :default => 0
  field :real_height, :type => Integer, :default => 0
  field :width, :type => Integer, :default => 0
  field :height, :type => Integer, :default => 0
  field :slides_count, :type => Integer, :default => 0
  field :thanked_count, :type => Integer, :default => 0
  field :comments_count, :type => Integer, :default => 0
  field :views_count, :type => Integer, :default => 0
  field :downloads_count, :type => Integer, :default => 0
  field :version, :type => Integer, :default => 0
  field :thanked_user_ids,:type=>Array,:default => []
  has_many :comments, as: :commentable
  #-=xunlei=-
  embeds_many :notes
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
        self.title_short = self.title.strip
      else
        self.user_name = rests[0].strip
        self.title_short = rests[1..-1].join(delim).strip
      end
    end
    
  end
  def titleize
    if self.title.present? and (self.new_record? or self.title_changed?)
      self.title.strip!
      reg1 = /^\[([^\[\]]+)\](.*)$/
      reg2 = /^【([^【】]+)】(.*)$/
      reg3 = /^@([^:：]*)[:：](.*)$/
      if self.title =~ reg1
        self.school_name = $1.strip
        self.analyse2($2)
      elsif self.title =~ reg2
        self.school_name = $1.strip
        self.analyse2($2)
      elsif self.title =~ reg3
        u=User.where(:slug=>$1).first
        u||=User.where(:name=>$1).first
        if !u
          u = User.new
          u.name = $1
          u.valid?
          if u.errors[:name].present?
            u.name = "_#{$1}"
            unless u.errors[:name].present?
              u.name_unknown = true
            end
          end
          u.slug = nil
          u.auto_slug
          u.email_unknown = true
          u.save(:validate => false)
        end
        self.user_id = u.id
        self.school_name = nil
        self.title_short = $2
      else
        self.school_name = nil
        self.title_short = self.title
      end
      if self.topic.blank?
        self.topic = '领域请求'
      end
    end
  end
  def uploader
    User.find(self.uploader_id)
  end
  def topic_inst
    ret = nil
    ret = Topic.where(:_id => self.topic_id).first unless self.topic_id.blank?
    if ret.nil?
      ret = Topic.locate('领域请求')
      self.update_attribute(:topic_id,ret.id)
    end
    ret
  end
  def topic_inst_was
    ret = nil
    ret = Topic.where(:_id => self.topic_id_was).first unless self.topic_id_was.blank?
    if ret.nil?
      ret = Topic.locate('领域请求')
    end
    ret
  end
  def school
    return nil if self.school_id.blank?
    School.where(:_id => self.school_id).first
  end
  def user
    return nil if self.user_id.blank?
    User.where(:_id => self.user_id).first
  end
  before_save :create_stuff!,:if=>'self.title_changed?'
  def create_stuff!
    self.is_thin = self.thin?
    if self.school_name.present?
      school = School.find_or_create_by(:name => self.school_name)
      user = User.find_or_initialize_by(:school_id => school.id, :name => self.user_name)
      if user.new_record?
        user.email_unknown = true
        user.save(:validate => false)
      end
      self.school_id = school.id
      self.user_id = user.id
    elsif self.user_id.blank?
      self.user_id = self.uploader_id
    end
  end
  before_save :create_topic!,:if=>'self.topic_changed?'
  def create_topic!
    topic = Topic.find_or_create_by(:name => self.topic)
    self.topic_id = topic.id
    self.topics = topic.ancestors
  end
  before_save :counter_work
  def counter_work
    if user_id_changed?
      if user_id_was.present? and old_user = User.where(:_id=>user_id_was).first
        old_user.inc(:coursewares_count,-1)
        old_user.school.inc(:coursewares_count,-1) if old_user.school
      end
      self.user.inc(:coursewares_count,1)
      self.user.school.inc(:coursewares_count,1) if self.user.school
    end
    if uploader_id_changed?
      if uploader_id_was.present? and old_user = User.where(:_id=>uploader_id_was).first
        old_user.inc(:upload_count,-1)
      end
      self.uploader.inc(:upload_count,1)
    end
  end  
  def wh_ratio
    self.width*1.0/self.height
  end
  def thin?
    return true if self.width.present? and self.height.present? and self.width < self.height
    return false
  end
  def revision
    if self.version > 0
      revision = self.version
    else
      revision = ''
    end
    revision
  end
  def slide_width
    return 960 if self.thin?
    return 1024
  end
  def go_to_normal
    self.update_attribute(:status,0)
    # insert_courseware_action_log('GONE_NORMAL')
  end
  def pinpic
    "cw/#{self.id}/#{self.pinpicname}"
  end
  def normal?
    0==self.status
  end
  validates_inclusion_of :sort,:in=>SORTSTR.keys
  def self.import_all!
    PreForumThread.all.each do |thread|
      ins=self.find_or_create_by(tid:thread.tid)
      attachment = PreForumAttachment.where(tid:thread.tid).first
      if attachment
        a = "PreForumAttachment#{thread.tid.to_s[-1]}".constantize.find_by_aid(attachment.aid)
        ins.title = thread.subject
        ins.filesize = a.filesize / 1000
        ins.pdf_filename = a.filename
        ins.sort = File.extname(a.filename)
        ins.sort = ins.sort[1..-1] if '.'==ins.sort[0]
        ins.downloads_count = attachment.downloads
        ins.save(:validate=>false)
      end
    end
  end
  
  def cover_small
    self.topic_inst.cover.small.url
  end
  def cover_small_was
    self.topic_inst_was.cover.small.url
  end
  def cover_small_changed?
    self.topic_id_changed?
  end
  redis_search_index(:title_field => :title,:ext_fields => [:cover_small,:views_count,:created_at,:topic], :score_field => :views_count)
end
