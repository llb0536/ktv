class UcApplications < ActiveRecord::Base
  self.table_name =  'uc_applications'
  establish_connection :psvr_ucenter
  def self.inheritance_column
    'inheritance_type'
  end
end
