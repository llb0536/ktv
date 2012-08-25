class UcDomains < ActiveRecord::Base
  set_table_name 'uc_domains'
  establish_connection :psvr_ucenter
end
