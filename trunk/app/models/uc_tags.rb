# -*- encoding : utf-8 -*-
class UcTags < ActiveRecord::Base
  include ActiveBaseModel
  self.table_name =  'uc_tags'
  establish_connection :psvr_ucenter
end
