class UcPmMessages4 < ActiveRecord::Base
  self.table_name =  'uc_pm_messages_4'
  establish_connection :psvr_ucenter
end
