task :psvr do
  User.skip_callback(:update, :before, :postpone_email_change_until_confirmation)
  User.skip_callback(:update, :after, :send_confirmation_instructions) 
  User.where(:email=>'').each{|u| u.update_attribute(:email_unknown,true)}
  User.where(:email_unknown=>true).each{|u| u.email = "unknown#{Time.now.to_i}#{rand}@example.com";u.save(:validate=>false)}
  User.where(:encrypted_password=>'').each{|u| u.fill_in_unknown_password;u.save(:validate=>false)}
end
