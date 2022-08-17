module Authentication
    extend ActiveSupport::Concern

    included do
      before_action :ensure_authenticated_user
    end
  
    private
      def ensure_authenticated_user
        puts "===========ensure_authenticated_user=============="

        authenticate_user(cookies.encrypted[:user_id]) 
      end
  
      def authenticate_user(user_id)
        puts "===========AUTHENTICATE_USER=============="

        if authenticated_user = User.find_by(id: user_id)
          cookies.encrypted[:user_id] ||= user_id
          
          arr1 =  User.all.to_a.sort_by{|e| e.id}.map {|u| myEncode(u.id) }

          arr2 =  arr1.inject {|r1, r2| "#{r1}" +"_"+ "#{r2}" }
          cookies[:user_ids] = arr2 if arr2
          
          @current_user = authenticated_user
          @current_user.update(status: "available")

        end
      end
  
      def unauthenticate_user(user_id)
        @current_user = User.find_by(id: user_id)
        @current_user.update(status: nil)
      
        puts "===========UNAUTHENTICATE_USER=============="
        ActionCable.server.disconnect(current_user: @current_user)
        @current_user = nil
        cookies.delete(:user_id)

        cookies.delete(:user_ids)

      end

      def myEncode(num)
        srand 101
        return "#{rand(100).to_s}ds35a#{rand(100).to_s}v93r4g6jk#{rand(100).to_s}k"+num.to_s+"wrdi98dtkh4"+rand(1000).to_s

      end
      
end