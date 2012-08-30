class UcTags < ActiveRecord::Base
  self.table_name =  'uc_tags'
  establish_connection :psvr_ucenter
end
