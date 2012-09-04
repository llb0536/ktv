# -*- encoding : utf-8 -*-
module UCenter
  module Version
    def check
      res = Ktv::JQuery.ajax({
        :url => "#{UCenter.getdef('UC_API')}/index.php",
        :type => 'POST',
        :accept => '*/*',
        :data => {
          m:'version',
          a:'check'
        },
        :psvr_response_anyway => true
      })
      return res
    end
    module_function(*instance_methods)
  end
end
