# coding: utf-8

namespace :mail do
  task :sendpack => :environment do
  datenow = Time.now.strftime("%Y%m%d")
  iid = '121116624'
  User.all.each do |user|
    begin

#if ["yunlong.lee@msn.com", "yunlong.li@kejian.tv"].include?(user.email)

      next if !user.current_mails || user.current_mails.empty?
      title = "有#{user.current_mails.count}条新通知等待您的查看" 
      if 1==user.current_mails.count
        title = user.current_mails.first[0]
      end
      bodycombo=<<DOC
      <!doctype html>
      <html>
      <head>
      <style type="text/css" media="screen">
      body {
      	color:#666;
      	font:14px/2em simsun;
      	background-color:#f1feea;
      }
      h6 {
      	font:bold 14px/2em simsun;
      	margin:0;
      }
      p {
      	margin:0;padding:0;
      }
      a {
      	color:#360;
      	font-weight:bold;
      	font-size:14px;
      	text-decoration:none;
      }
      dd {
      	margin-left:0;
      	font-size:12px;
      }
      dd a {
      	font-size:12px;
      }
      .header {
      	width:650px;height:47px;
      	margin:5px auto;
      }
      .notifier {
      	border-bottom:1px solid #ccc;
      	font-weight:bold;
      	width:600px;
      	margin:0 auto;
      	height:40px; line-height:50px;
      }
      .main {
      	width:650px;
      	margin:0 auto;
      	border:1px solid #ccc;
      	background-color:#fff;
      }
      .footer {
      	width:650px;
      	margin:0 auto;
      	text-align:right;
      	font-size:12px;
      }
      .contentItem {
      	background:url("http://wendao.kejian.tv/assets/usermailerbg.png") repeat-x left bottom;
      	padding:20px;
      }
      .contentItem div {
      	margin:5px 0;
      }
      .pictureItem {
      	font-size:12px;
      }
      .pictureItem img {
      	float:left;
      	margin-right:10px;
      }
      </style>
      </head>
      <body style="color:#666;font:14px/2em simsun;background-color:#f1feea;">
      <div visibility=hidden><IMG SRC="http://cnt.kejian.tv/Market/edm.gif?sid=#{iid}&site=edm_#{datenow}&zpsenddate=#{datenow}&zpemail=#{Setting.smtp_username}&zpuserid=" width="0" height="0" ></div>
<div class="header" style="width:650px;height:47px;margin:5px auto;">
      <a href="http://wendao.kejian.tv"><img src="http://wendao.kejian.tv/assets/usermailerlogo.png" width="650" height="47" /></a>
      </div>
<div class="main" style="width:650px;margin:0 auto;border:1px solid #ccc;background-color:#fff;">
	<div class="notifier" style="border-bottom:1px solid #ccc;font-weight:bold;width:600px;margin:0 auto;height:40px; line-height:50px;">您在求助上最近的通知</div>
DOC
realcontent = ''
      user.current_mails.each do |ar|
        #next if ar[1].blank?
        next if ar[1] == ""
        realcontent+='<div class="pictureItem">'
        realcontent+=ar[1]
        realcontent+='</div>'
      end
      #next if realcontent.blank?
      next if realcontent==''
      bodycombo+=realcontent
      bodycombo+=<<DOC
      </div>
      <div class="footer" style="width:650px;margin:0 auto;text-align:right;font-size:12px;">
      这是一封系统邮件，请勿回复<br/>
      <a href="http://wendao.kejian.tv">http://wendao.kejian.tv</a> | <a href="http://wendao.kejian.tv/users/edit">邮件通知设置</a>

      </div>
      </body>
      </html>
DOC
      user.current_mails = []
      user.save! if user.changed?
      begin
        url_prefix="http://cnt.kejian.tv/Market/whole_counter_edm.jsp?sid=#{iid}&site=edm_#{datenow}&zpsenddate=#{datenow}&zpemail=#{Setting.smtp_username}&zpuserid=&url="
        bodycombo.gsub!(/<a([^<>]+)href="([^"]+)"([^<>]*)>/) do |match|
          "<a#{$1}href=\"#{url_prefix}#{$2}\"#{$3}>"
        end
      rescue => e
        p e
      end

      UserMailer.simple(user.email, '[求助]'+title, bodycombo,{adid: iid,adsite: "edm_#{datenow}"}).deliver!
      p "send ok to #{user.email}"

#end

   rescue Exception=>e
     p user.id
     p user.slug
     p e
    #p e.backtrace
     p "send !!! failed !!! to #{user.email} with slug #{user.slug}"
   end

    end
  end
end


