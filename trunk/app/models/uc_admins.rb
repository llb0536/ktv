# -*- encoding : utf-8 -*-
class UcAdmins < ActiveRecord::Base
  include ActiveBaseModel
  self.table_name =  'uc_admins'
  establish_connection :psvr_ucenter
end
