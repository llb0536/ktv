# -*- encoding : utf-8 -*-
class UserRegip < Mongoid::Migration
  def self.up
    User.skip_callback(:update, :before, :postpone_email_change_until_confirmation)
    User.skip_callback(:update, :after, :send_confirmation_instructions)
    #User.all.each{|u| u.update_attribute(:regip,(u.current_sign_in_ip.blank? ? u.last_sign_in_ip.blank? ? nil : u.last_sign_in_ip : u.current_sign_in_ip))}
    # User.all.each{|u| if(u.email.length>32);e=u.email;u.update_attribute(:email,e.split('.')[0].split('unknown')[-1]+'@v.com');end}
    #User.all.each{|u| u.sync_to_uc! if u.active_for_authentication?}
  end

  def self.down
  end
end
