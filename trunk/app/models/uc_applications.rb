class UcApplications < ActiveRecord::Base
  include ActiveBaseModel
  self.table_name =  'uc_applications'
  establish_connection :psvr_ucenter
  def self.inheritance_column
    'inheritance_type'
  end
end
