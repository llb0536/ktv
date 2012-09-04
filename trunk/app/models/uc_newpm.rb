# -*- encoding : utf-8 -*-
class UcNewpm < ActiveRecord::Base
  include ActiveBaseModel
  self.table_name =  'uc_newpm'
  establish_connection :psvr_ucenter
end
