# -*- encoding : utf-8 -*-
class Course
  include Mongoid::Document
  include Mongoid::Timestamps
  include Redis::Search
  include BaseModel
  field :department
  def department_ins
    Department.where(:name=>self.department).first
  end
  field :ctype
  field :number
  field :name
  field :fid
  field :coursewares_count,:type=>Integer,:default=>0
  field :years,:type=>Array,:default=>[]
  field :is_yjs,:type=>Boolean,:default=>false
  
  index :fid
  cache_consultant :name,:from_what => :fid,:no_callbacks=>true
  cache_consultant :department,:from_what => :fid,:no_callbacks=>true
  
  embeds_many :teachings
  
  def self.reflect_onto_discuz!
    PreForumForum.delete_all
    self.asc('number').each_with_index do |item,index|
      PreForumForum.insert2(1,"[#{item.number}] #{item.name}",index+1)
    end
    self.fid_fill!
  end
  def self.fid_fill!
    self.asc('number').each_with_index do |item,index|
      item.update_attribute(:fid,PreForumForum.find_by_name("[#{item.number}] #{item.name}").fid)
    end
  end
  def self.shoudongtianjia!(department,number,name,*teachers)
    item=self.create!(department:department,number:number,name:name)
    f=PreForumForum.insert2(1,"[#{item.number}] #{item.name}",PreForumForum.count+1)
    item.update_attribute(:fid,f.fid)
    Teaching.shoudongtianjia!(item,*teachers)
  end
  def self.import_coursewares_count
    self.all.each{|cw| cw.update_attribute(:coursewares_count,PreForumThread.where(fid:cw.fid).count);}
  end
  def name_long
    "[#{self.number}] #{self.name}"
  end
  def name_long_changed?
    self.number_changed? or self.name_changed?
  end
  def name_long_was
    "#{self.number_was} #{self.name_was}"
  end
  redis_search_index(:title_field => :name,
                     :alias_field => :name_long,
    :prefix_index_enable => true,
    :ext_fields => [:fid,:name_long],
    :score_field => :coursewares_count)
end

