class UcNewpm < ActiveRecord::Base
  self.table_name =  'uc_newpm'
  establish_connection :psvr_ucenter
end
