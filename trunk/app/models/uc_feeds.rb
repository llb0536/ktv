class UcFeed < ActiveRecord::Base
  establish_connection :psvr_ucenter
end
