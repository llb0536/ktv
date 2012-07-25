# coding: utf-8
class DeviseMailer < Devise::Mailer
  layout false
  helper :application,:users
  def invitation_instructions(vip_id,current_invitor_id)
    @vip = User.find(vip_id)
    @invitor = User.find(current_invitor_id)
    mail(
          :subject => "#{@invitor.name}邀请您来课件交流系统联络",
          :from => "\"#{@invitor.name}\" <#{@invitor.email}>",
          :to => "\"#{@vip.name}\" <#{@vip.email}>",
          :bcc => ["pmq2001@gmail.com"],
          :reply_to => @invitor.email
    )
  end
end