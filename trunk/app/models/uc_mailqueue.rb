class UcMailqueue < ActiveRecord::Base
  establish_connection :psvr_ucenter
end
