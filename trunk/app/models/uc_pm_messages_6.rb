# -*- encoding : utf-8 -*-
class UcPmMessages6 < ActiveRecord::Base
  include ActiveBaseModel
  self.table_name =  'uc_pm_messages_6'
  establish_connection :psvr_ucenter
end
