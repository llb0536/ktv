class UcTags < ActiveRecord::Base
  set_table_name 'uc_tags'
  establish_connection :psvr_ucenter
end
