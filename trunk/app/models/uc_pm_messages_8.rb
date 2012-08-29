class UcPmMessages8 < ActiveRecord::Base
  self.table_name =  'uc_pm_messages_8'
  establish_connection :psvr_ucenter
end
