# -*- encoding : utf-8 -*-
class UcPmMessages7 < ActiveRecord::Base
  include ActiveBaseModel
  self.table_name =  'uc_pm_messages_7'
  establish_connection :psvr_ucenter
end
