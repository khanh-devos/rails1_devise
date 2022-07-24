class Job3Job < ApplicationJob
  queue_as :default


  def perform(*args)
    puts "+++++++++++++++++++"
    puts "a send to #{args.first} : #{t.strftime("%X")}"
    puts "+++++++++++++++++++"

    #sidekiq/redis will sending email while resetting password
    WelcomeMailer.with(user: args.first).welcome_email.deliver_now
    
  end
end
