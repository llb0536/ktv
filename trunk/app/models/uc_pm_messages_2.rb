class UcPmMessages2 < ActiveRecord::Base
  self.table_name =  'uc_pm_messages_2'
  establish_connection :psvr_ucenter
end
