# -*- encoding : utf-8 -*-
class UcPmMessages3 < ActiveRecord::Base
  include ActiveBaseModel
  self.table_name =  'uc_pm_messages_3'
  establish_connection :psvr_ucenter
end
