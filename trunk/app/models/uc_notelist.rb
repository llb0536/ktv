# -*- encoding : utf-8 -*-
class UcNotelist < ActiveRecord::Base
  include ActiveBaseModel
  self.table_name =  'uc_notelist'
  establish_connection :psvr_ucenter
end
