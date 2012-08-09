# -*- encoding : utf-8 -*-
module Ktv
  Consumers = Hash[
    'renren' => [:renren,'3fb8f24e83c34ebc9beed75ca2b06ef6', '982706a492a540fa8f45b7f7d56af82a', '人人网'],     # http://app.renren.com/developers/newapp/164538/
    'weibo' => [:weibo,'2931187294', '015b4255af69a67a912cc5d5cfce9e95', '新浪微博'],   # http://open.weibo.com/webmaster/console?siteid=2931187294  
    'douban' => [:douban,'07e230bb9fdb7e4f17a69232df927aed', 'ed0780c0c5504880', '豆瓣'],  # http://www.douban.com/service/apikey/07e230bb9fdb7e4f17a69232df927aed/  
    'qq_connect' => [:qq_connect,'100285598', 'fbe0ed28f8f558dfb17f5bcd287de368', 'QQ'],  # http://connect.qq.com/manage/
    'google_oauth2' => [:google_oauth2,'604807451178.apps.googleusercontent.com', 'mIpedI06iXeG_JSOXKs1e0tE', 'Google'],  # https://code.google.com/apis/console/
    'github' => [:github,'df89e77ea92fc8d0bd6c', 'adbf7b1ca83dc439c80097593b9576eb239fbcea', 'Github'],  # https://github.com/settings/applications
  ]
end

if Rails.env.staging?
  $debug_logger = Logger.new("#{Rails.root}/log_staging/#{Rails.env}.debug.log", File::WRONLY | File::APPEND)
else
  $debug_logger = Logger.new("#{Rails.root}/log/#{Rails.env}.debug.log", File::WRONLY | File::APPEND)
end

