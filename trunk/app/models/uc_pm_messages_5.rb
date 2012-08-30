class UcPmMessages5 < ActiveRecord::Base
  self.table_name =  'uc_pm_messages_5'
  establish_connection :psvr_ucenter
end
