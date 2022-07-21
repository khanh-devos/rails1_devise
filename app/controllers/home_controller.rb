class HomeController < ApplicationController
  #before_action :checkLogin, only: %i[ userfriend ]
  before_action :authenticate_user!, except: [ :index, :about ] 


  def index
    #p /<.?>/.match("<a><b>")[0]
    @users = User.all


    @tests = ['test1', 'test2']
  end

  def about
    @user = current_user
  end
  
  def userfriend
    @userfriends = current_user.friends.all
  end

  def checkLogin
    redirect_to friends_url, notice: "Please log in first !!" unless user_signed_in?
  end

end
