class UcSettings < ActiveRecord::Base
  set_table_name 'uc_settings'
  establish_connection :psvr_ucenter
end
