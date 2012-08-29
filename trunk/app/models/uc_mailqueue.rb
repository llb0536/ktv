class UcMailqueue < ActiveRecord::Base
  self.table_name =  'uc_mailqueue'
  establish_connection :psvr_ucenter
end
