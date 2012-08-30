class UcVars < ActiveRecord::Base
  self.table_name =  'uc_vars'
  establish_connection :psvr_ucenter
end
