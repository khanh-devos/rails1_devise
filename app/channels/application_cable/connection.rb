module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
    rescue_from StandardError, with: :report_error

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user.email[0,2]
    end

    private
      def find_verified_user
        puts "(((((((((((#{cookies.encrypted[:user_id]}))))))))"

        if verified_user = User.find_by(id: cookies.encrypted[:user_id])
          verified_user.update(status: nil)

          puts "(((((((((((verfied connection))))))))"
          #puts cookies.to_h.each {|k,v| print k,": ",v,"\n" }
          #puts ActionCable.server.connections

          verified_user
          
        else
          reject_unauthorized_connection
          
        end
      end

      #For error reprot
      def report_error(e)
        puts "+++++++++++++++++ERROR+++++++++"
        puts e
        puts "+++++++++++++++++ERROR+++++++++"

      end

  end
end
