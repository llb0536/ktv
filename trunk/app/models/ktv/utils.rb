# -*- encoding : utf-8 -*-
module Ktv
  class Utils
    # To execute the block code in a exception-free manner
    # all exceptions are sent to the logger on the error level for inspection.
    # returns nil on error
    def self.safely(ret=nil,&block)
      return yield
    rescue => e
      Ktv.config.logger.error "#{e}"
      return ret
    end

    def self.get_parser(page)
      if page.encoding_error?
        return Nokogiri::HTML( page.body.getout_from(page.encoding) )
      else
        return page.parser
      end
    end
    
    def self.js_strlen(str)
      len=0
      i=0
      while i<str.length
        if str[i].ord>255
          len+=2
        else
          len+=1
        end
        i+=1
      end
      return len
    end
  
    def self.js_chinese(str)
      ret=0
      i=0
      while i<str.length
        if str[i].ord>255
          ret+=1
        end
        i+=1
      end
      return ret
    end
  end
end
