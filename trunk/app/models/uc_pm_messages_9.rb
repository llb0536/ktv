class UcPmMessages9 < ActiveRecord::Base
  self.table_name =  'uc_pm_messages_9'
  establish_connection :psvr_ucenter
end