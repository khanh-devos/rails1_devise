class StreamJob < ApplicationJob
    queue_as :default
  
    def perform(*args)
        id = args.first        
        state = args.last
        
        puts "++++++++STREAM JOB+++++++++++"
        puts ActionCable.server.connections
        
        #streaming the specific channel with auto-ID = current-user.id
        # AppearanceChannel.broadcast_to(
        #     current_user123,        
        #     title: 'New things!',
        #     body: "This is from the StreamJob #{current_user123.username.upcase} said: #{public_msg}"
        # )

        #create and streaming into "chat_Room 1", no one get it
        ActionCable.server.broadcast("chat_Room1", 
            { sent_by: id,
              body: state 
            }
        )      
        
    end
end
  