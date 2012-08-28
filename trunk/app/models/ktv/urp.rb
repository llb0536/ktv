# -*- encoding : utf-8 -*-
module Ktv
  class Urp
    extend Ktv::Helpers::Config
    include Ktv::Helpers::Config
    include Shared::MechanizeParty
    def start_mode(mode,username,password)
      @mode = mode
      case @mode
      when :cnu
        @base_url = 'http://202.204.208.75'
        @page = @agent.post("#{@base_url}/loginAction.do",{ldap:'auth',zjh:username,mm:password})
      end
    end
    
  end
end
