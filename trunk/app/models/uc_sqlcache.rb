class UcSqlcache < ActiveRecord::Base
  set_table_name 'uc_sqlcache'
  establish_connection :psvr_ucenter
end
