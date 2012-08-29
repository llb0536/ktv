class UcSettings < ActiveRecord::Base
  self.table_name =  'uc_settings'
  establish_connection :psvr_ucenter
end
