class UcNewpm < ActiveRecord::Base
  set_table_name 'uc_newpm'
  establish_connection :psvr_ucenter
end
