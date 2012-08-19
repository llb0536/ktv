module UCenter
  module Php

    def md5(string)
      return Digest::MD5.hexdigest(string.to_s)
    end
    def substr(string, from, to = nil)
      #If 'to' is not given it should be the total length of the string.
      if to == nil
        to = string.length
      end

      #The behaviour with a negative 'to' is not the same as in PHP. Hack it!
      if to < 0
        to = string.length + to
      end

      #Cut the string.
      string = "#{string[from.to_i, to.to_i]}"

      #Sometimes the encoding will no longer be valid. Fix that if that is the case.
      if !string.valid_encoding? and Php4r.class_exists("Iconv")
        string = Iconv.conv("UTF-8//IGNORE", "UTF-8", "#{string}  ")[0..-2]
      end

      #Return the cut string.
      return string
    end
    def microtime(get_as_float = false)
      microtime = Time.now.to_f

      return microtime if get_as_float

      splitted = microtime.to_s.split(",")
      return "#{splitted[0]} #{splitted[1]}"
    end
    def strlen(str)
      str.length
    end
    def base64_decode(str)
      return Base64.decode64(str.to_s)
    end

    def base64_encode(str)
      #The strict-encode wont do corrupt newlines...
      if Base64.respond_to?("strict_encode64")
        return Base64.strict_encode64(str.to_s)
      else
        return Base64.encode64(str.to_s)
      end
    end
    def time()
      Time.now.to_i
    end
    def range(first_value, limit_value)
      (first_value..limit_value).to_a
    end
    #Array-function emulator.
    def array(*ele)
      return {} if ele.length <= 0

      if ele.length == 1 and ele.first.is_a?(Hash)
        return ele.first
      end

      return ele
    end
    def ord(char)
      char.to_s.ord
    end
    def chr(num)
      num.chr
    end
    def str_replace(a,b,c)
      if a.respond_to?(:each)
        i = 0
        ret = c
        while i < a.length
          b[i] ||= ''
          ret = str_replace(a[i],b[i],ret)
        end
        return ret
      else
        return c.gsub(a,b)
      end
    end

    def authcode(string, operation = 'DECODE', key = '', expiry = 0) 

    	ckey_length = 4;	
      # 随机密钥长度 取值 0-32;
    	# 加入随机密钥，可以令密文无任何规律，即便是原文和密钥完全相同，加密结果也会每次不同，增大破解难度。
    	# 取值越大，密文变动规律越大，密文变化 = 16 的 ckey_length 次方
    	# 当此值为 0 时，则不产生随机密钥

    	key = md5(key.present? ? key : UCenter.getdef('UC_KEY'));
    	keya = md5(substr(key, 0, 16));
    	keyb = md5(substr(key, 16, 16));
    	keyc = ckey_length!=0 ? (operation == 'DECODE' ? substr(string, 0, ckey_length): substr(md5(microtime()), -ckey_length)) : '';

    	cryptkey = keya+md5(keya+keyc);
    	key_length = strlen(cryptkey);

    	string = operation == 'DECODE' ? base64_decode(substr(string, ckey_length)) : sprintf('%010d', expiry!=0 ? expiry + time() : 0)+substr(md5(string+keyb), 0, 16)+string;
    	string_length = strlen(string);

    	result = '';
    	box = range(0, 255);

    	rndkey = array();
    	i = 0;
    	while( i <= 255) 
    		rndkey[i] = ord(cryptkey[i % key_length]);
    		i+=1
    	end

      j = i = 0;
    	while( i < 256) 
    		j = (j + box[i] + rndkey[i]) % 256;
    		tmp = box[i];
    		box[i] = box[j];
    		box[j] = tmp;
    		i+=1
    	end

    	a = j = i = 0;
    	while( i < string_length)
    		a = (a + 1) % 256;
    		j = (j + box[a]) % 256;
    		tmp = box[a];
    		box[a] = box[j];
    		box[j] = tmp;
    		result += chr(ord(string[i]) ^ (box[(box[a] + box[j]) % 256]));
    		i+=1
    	end

    	if(operation == 'DECODE')
    		if((substr(result, 0, 10) == 0 || substr(result, 0, 10).to_i - time() > 0) && substr(result, 10, 16) == substr(md5(substr(result, 26)+keyb), 0, 16))
    			return substr(result, 26);
    		else
    			return '';
        end
    	else
    		return keyc+str_replace('=', '', base64_encode(result));
    	end

    end
    
    
    module_function(*instance_methods)
  end
end
