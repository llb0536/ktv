class UcDomains < ActiveRecord::Base
  self.table_name =  'uc_domains'
  establish_connection :psvr_ucenter
end
