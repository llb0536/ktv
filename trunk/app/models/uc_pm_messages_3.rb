class UcPmMessages3 < ActiveRecord::Base
  self.table_name =  'uc_pm_messages_3'
  establish_connection :psvr_ucenter
end
