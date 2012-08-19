module UCenter
  module Version
    def check
      res = Ktv::JQuery.ajax({
        :url => "#{UCenter.getdef('UC_API')}/?m=version&a=check",
        :type => 'POST',
        :accept => :xml,
        :data => {
          
        },
        :psvr_response_anyway => true
      })
      return res
    end
    module_function(*instance_methods)
  end
end