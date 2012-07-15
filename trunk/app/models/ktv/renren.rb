# -*- encoding : utf-8 -*-
module Ktv
  class Renren
    extend Ktv::Helpers::Config
    include Ktv::Helpers::Config

    class << self
      def name_okay?(q)
        okay = true
        res = Ktv::JQuery.ajax({
          url:'http://reg.renren.com/AjaxRegisterAuth.do',
          type:'POST',
          data:{
            "authType"=>"name",
            "rndval"=>Time.now.to_i.to_s,
            "t"=>Time.now.to_i.to_s,
            "value"=>q
          },
          psvr_response_anyway: true
        })
        okay = ('OKNAME'==res) if res.present?
        return okay
      end
    end
  end
end
