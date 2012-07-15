# coding: utf-8

namespace :mail do
  task :sendpack_expert => :environment do
    User.all.each do |user|
begin
      next if !user.current_mails || user.current_mails.empty?
      next unless user.is_expert
      title = "有#{user.current_mails.count}条新通知等待您的查看" 
      if 1==user.current_mails.count
        title = user.current_mails.first[0]
      end
      bodycombo=<<DOC

<div style="background:#FFF; font-size:12px; width:500px;">

        <div><a href="http://wendao.zhaopin.com" title="问道" target="_blank"><img src="http://wendao.zhaopin.com/assets/mail_logo.png" /></a></div>
        <div style="width:90%;margin:0 auto;">
                <div style="font-size:14px;height:30px; line-height:30px; border-bottom:3px solid #bbb;font-weight:bold;margin-bottom:20px;">你在[问道]上的最
近的通知</div>
<ul>

DOC
      bodycombo+=user.current_mails.collect{|ar| ar[1]}.join('<br><br>')
bodycombo+=<<DOC
</ul>
                <div style="border-top:3px solid #bbb;text-align:right;margin-top:20px;">
                        这是一封系统邮件，请勿回复<br/>
                        <a style="color:#999;" href="http://wendao.zhaopin.com">http://wendao.zhaopin.com</a> &nbsp;|&nbsp; <a style="color:#999;" href="http://wendao.zhaopin.com/users/edit#mail_notify_settings">邮件通知设置</a>
                </div>
        </div>

</div>

DOC
      user.current_mails = []
      user.save! if user.changed?
      UserMailer.simple(user.email, '[问道]'+title, bodycombo).deliver!
p "send ok to #{user.email}"
   rescue Exception=>e
     p user.id
     p e
p "send failed to #{user.email}"
   end

    end
  end
end


