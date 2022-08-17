class HomeController < ApplicationController
  include HomeHelper

  #before_action :checkLogin, only: %i[ userfriend ]
  #before_action :authenticate_user!, except: [ :index, :about ] 
  before_action :authenticate_user!



  def index
    #p /<.?>/.match("<a><b>")[0]
    @users = User.all
    @tests = ['test1', 'test2']

    @subs = getsubs

   
  end

  def about
    @user123 = current_user

    begin 
      #Job1Job.perform_later("test job1")
      #Job2Job.set(wait: 5.seconds).perform_later("test job2")
      
      # if @user123.email.eql? "dreamproperty.khanh@gmail.com"
      #   #notice: despite this msg from who, all client can receive
      # end 
      
        
    rescue =>err 
      p err 
    end
    
  end
  
  def userfriend
    @userfriends = current_user.friends.all
    
  end

  def checkLogin
    redirect_to friends_url, notice: "Please log in first !!" unless user_signed_in?
  end

  

end
