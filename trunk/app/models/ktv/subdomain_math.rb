# -*- encoding : utf-8 -*-
module Ktv
  class SubdomainMath
    def self.matches?(request)
      request.subdomain.present? and request.subdomain.starts_with?('math.')
    end
  end
end
