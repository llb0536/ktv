# -*- encoding : utf-8 -*-
class UcPmMessages2 < ActiveRecord::Base
  include ActiveBaseModel
  self.table_name =  'uc_pm_messages_2'
  establish_connection :psvr_ucenter
end
