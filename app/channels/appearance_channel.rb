class AppearanceChannel < ApplicationCable::Channel
  include HomeHelper

  def subscribed
    # puts "========subscribed=========="

    #For pushing data from back-end to front-end <=> received() method
    #stream_for current_user

    #follow the channel "chat_Room 1", room:
    stream_from "chat_#{params[:id]}"

    #stream_for current_user
    
  end

  def unsubscribed
    # puts "========unsubscribed=========="
    current_user.update(status: nil)
    self.doBroadcast(nil)
    
  end

  
  def appear(data)
    # puts "========APPEAR #{current_user.email}=========="
    current_user.update(status: data["appearing_on"])
    
    self.doBroadcast("available")

  end

  def away(data)
    
    current_user.update(status: data["appearing_on"])

    self.doBroadcast("away")
    
  end

  def doBroadcast(state)
    #Take data from Room 1, then send to to all client, including senders
    #Without this, no one can read the message.
    # puts "========START : #{current_user.email}=========="
    
    StreamJob.perform_later("#{myEncode(current_user.id)}", state)


  end

  
end
