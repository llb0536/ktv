class UcApp < ActiveRecord::Base
  set_table_name 'uc_app'
  establish_connection :psvr_ucenter
end
