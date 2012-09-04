# -*- encoding : utf-8 -*-
module Discuz
  module Utils
    def self.formhash(opts={},specialadd = '')
      #hashadd = defined('IN_ADMINCP') ? 'Only For Kejian.TV Admin Control Panel' : '';
      hashadd = ''
      return UCenter::Php.substr(UCenter::Php.md5(UCenter::Php.substr(Time.now.to_i.to_s, 0, -7)+"#{opts['username']}#{opts['uid']}#{opts['authkey']}#{hashadd}#{specialadd}"), 8, 8);
    end
  end
end
