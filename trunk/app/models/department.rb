class Department
  include Mongoid::Document
  include Mongoid::Timestamps
  include BaseModel
  field :name
  has_many :users
end