# coding: utf-8
class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  
  include BaseModel
  def self.real_create(params,current_user)
    comment = Comment.new(params[:comment])
    comment.commentable_type = comment.commentable_type.titleize
    comment.user_id = current_user.id
    return [comment.save,comment]
  end
  def asynchronously_clean_me
    # --------------
    self.user.inc(:comments_count,-1)
    self.commentable.inc(:comments_count,-1)
    self.logs.each do |c|
      Notification.where(:log_id=>c._id).each do |n|
        n.update_attribute(:deleted,1)
      end
      c.delete
    end
  end
  field :body
  #后台删除操作记录
  field :deletor_id
  field :deleted_at, :type => Time
  #添加后台删除操作记录
  def info_delete(user_id)
    Resque.enqueue(HookerJob,self.class.to_s,self.id,:async_info_delete,user_id)
  end
  def async_info_delete(user_id)
    self.update_attribute(:deletor_id,BSON::ObjectId(user_id))
    self.update_attribute(:deleted_at,Time.now)
  end
  
  belongs_to :commentable, :polymorphic => true
  belongs_to :ask, :foreign_key => "commentable_id"
  belongs_to :answer, :foreign_key => "commentable_id"
  
  belongs_to :user
  has_many :logs, :class_name => "Log", :foreign_key => "target_id"

  index :user_id
  index :commentable_type
  index :commentable_id
  index :created_at

  validates_presence_of :body
  validates_length_of :body,:maximum=>4000
  after_create proc{
    Resque.enqueue(HookerJob,self.class.to_s,self.id,:msg_center_action)
  }
  def msg_center_action
    if 'Answer'==self.commentable_type
      send_to_msg_center({
        "SourceId"=>"",
        "MsgType"=>30,
        "MsgSubType"=>3010,
        "Receiver"=>self.commentable.user.zhaopin_ud,
        "Sender"=>"#{self.user.name}",
        "SenderUrl"=>"http://wendao.zhaopin.com/users/#{self.user.slug}",
        "SendContent"=>"<P><a href=\"http://wendao.zhaopin.com/users/#{self.user.id}\">#{self.user.name}</a>评论了你的回答“<a href=\"http://wendao.zhaopin.com/asks/#{self.commentable.ask.id}\">#{self.commentable.ask.title}</a>”。</P>",
        "SendContentUrl"=>"",
        "OperateUrl"=>""
    	})
    end
  end

  # 敏感词验证
  before_validation :check_spam_words
  def check_spam_words
    if self.spam?("body")
      return false
    end
  end

  before_create :fix_commentable_id
  def fix_commentable_id
    if self.commentable_id.class == "".class
      self.commentable_id = BSON::ObjectId(self.commentable_id)
    end
  end
  before_save :counter_work
  def counter_work
    if new_record?
      self.commentable.inc(:comments_count,1)
      self.user.inc(:comments_count,1)
    end
  end
  after_create :create_log
  
  def create_log
    log = CommentLog.new
    log.user_id = self.user_id
    log.comment = self
    log.target_id = self.id
    log.action = "NEW_#{self.commentable_type.upcase}_COMMENT"
    if self.commentable_type == "Answer"
      log.target_parent_id = (self.answer and self.answer.ask) ? self.answer.ask.id : ""
      log.target_parent_title = (self.answer and self.answer.ask) ? self.answer.ask.title : ""
      log.title = self.commentable_id
    else
      log.target_parent_title = self.ask ? self.ask.title : ""
      log.target_parent_id = self.commentable_id
      log.title = log.target_parent_title
    end
    log.diff = ""
    log.save
  end


  # 
  # after_destroy :dec_counter_cache
  # def dec_counter_cache
  #   self.commentable.comments_count = self.commentable.comments.count
  #   self.commentable.save
  # end
end