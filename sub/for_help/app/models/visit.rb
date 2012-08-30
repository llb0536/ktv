class Visit
  include Mongoid::Document

  field :page
  field :created_at,:type=>Time
  
  belongs_to :user
  
  index :page
  index :created_at
  
end
