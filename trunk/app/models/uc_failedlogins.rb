class UcFailedlogins < ActiveRecord::Base
  self.table_name =  'uc_failedlogins'
  establish_connection :psvr_ucenter
end