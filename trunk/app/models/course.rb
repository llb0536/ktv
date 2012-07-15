class Course
  include Mongoid::Document
  include Mongoid::Timestamps
  include BaseModel
  field :name
  belongs_to :user
end