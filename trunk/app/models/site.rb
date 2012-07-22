# -*- encoding : utf-8 -*-
class Site
  include Mongoid::Document
  field :name
  field :att,:type => Hash,:default => {}
  field :err_msgs,:type=>Array,:default=>[]
end

