class UcPmMessages0 < ActiveRecord::Base
  include ActiveBaseModel
  self.table_name =  'uc_pm_messages_0'
  establish_connection :psvr_ucenter
end
