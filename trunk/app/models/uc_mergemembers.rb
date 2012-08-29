class UcMergemembers < ActiveRecord::Base
  self.table_name =  'uc_mergemembers'
  establish_connection :psvr_ucenter
end
