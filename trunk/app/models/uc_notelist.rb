class UcNotelist < ActiveRecord::Base
  self.table_name =  'uc_notelist'
  establish_connection :psvr_ucenter
end
