module Wendao
  class Client
    module Asks
      def user_asks(user_slug, options={})
        get("/users/#{user_slug}/asks", options)
      end
      
      def asks(options={})
        options = { :per_page => 35, :sha => branch }.merge options
        get("/asks", options)
      end
      alias :list_asks :asks

      def ask(id, options={})
        get("/asks/#{id}", options)
      end

      def ask_comments(id, options={})
        get("/asks/#{id}/comments", options)
      end

      def ask_comment(id, comment_id, options={})
        get("/asks/#{id}/comments/#{comment_id}", options)
      end

    end
  end
end
