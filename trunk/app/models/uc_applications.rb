class UcApplications < ActiveRecord::Base
  set_table_name 'uc_applications'
  establish_connection :psvr_ucenter
end
