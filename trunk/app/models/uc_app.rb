class UcApp < ActiveRecord::Base
  self.table_name =  'uc_app'
  establish_connection :psvr_ucenter
end
