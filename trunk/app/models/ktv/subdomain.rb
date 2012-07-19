# -*- encoding : utf-8 -*-
module Ktv
  class Subdomain
    def self.match(request)
      if request.subdomain.present? and request.subdomain =~ /ibeike(\.|$)/
        return '__ibeike'
      elsif (request.subdomain.present? and request.subdomain =~ /cnu(\.|$)/) or 'cnu.edu.cn'==request.domain
        return '__cnu'
      else
        return ''
      end
    end
  end
end
