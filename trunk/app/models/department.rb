# -*- encoding : utf-8 -*-
class Department
  include Mongoid::Document
  include Mongoid::Timestamps
  include Redis::Search
  include BaseModel
  field :name
  field :fid
  field :courses_count,:type=>Integer,:default=>0
  field :courses_count1,:type=>Integer,:default=>0
  field :courses_count2,:type=>Integer,:default=>0
  validates_uniqueness_of :name,:message=>'与已有院系名重复，请尝试其他名'
  cache_consultant :fid,:from_what => :name,:no_callbacks=>true
  def courses
    Course.where(:department=>self.name)
  end
  def set_counter
    self.update_attribute(:courses_count,courses.count)
    self.update_attribute(:courses_count1,courses.where(:is_yjs.ne=>true).count)
    self.update_attribute(:courses_count2,courses.where(:is_yjs=>true).count)
  end
  def self.fid_fill!
    self.asc('created_at').each_with_index do |item,index|
      item.update_attribute(:fid,PreForumForum.find_by_name_and_type("#{item.name}",'group').fid)
    end
  end
  def self.reflect_onto_discuz!
    self.asc('created_at').each_with_index do |item,index|
      PreForumForum.insert1("#{item.name}",index+1)
    end
    self.fid_fill!
  end
end
