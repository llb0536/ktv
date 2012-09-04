class Department
  include Mongoid::Document
  include Mongoid::Timestamps
  include Redis::Search
  include BaseModel
  field :name
  field :fid
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
