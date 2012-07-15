module Wendao
  class Client
    module Users
      EMAIL_RE = /[\w.!#\$%+-]+@[\w-]+(?:\.[\w-]+)+/
      # Get a single user
      #
      # @param user [String] A Wendao user slug.
      # @return [Hashie::Mash]
      # @example
      #   Wendao.user("sferik")
      def user(user=nil)
        if user
          get("/users/#{user}", {})
        else
          get("/user", {})
        end
      end
    end
  end
end
