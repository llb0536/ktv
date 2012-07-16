# coding: utf-8
class School
  include Mongoid::Document
  include Mongoid::Timestamps
  include Redis::Search
  include BaseModel
  field :name
end
