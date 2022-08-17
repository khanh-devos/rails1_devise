class Job3Job < ApplicationJob
  queue_as :default


  def perform(user)
    # t = Time.now
    # puts "+++++++++++++++++++"
    # puts "a send to #{user} : #{t.strftime("%X")}"
    # puts "+++++++++++++++++++"

    #sidekiq/redis will sending email while resetting password
    WelcomeMailer.with(user: user).welcome_email.deliver_now
    
  end
end
