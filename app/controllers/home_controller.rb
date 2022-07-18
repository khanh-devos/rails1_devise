class HomeController < ApplicationController
  
  def index
    #p /<.?>/.match("<a><b>")[0]
    @tests = ['test1', 'test2']
  end

  def about
    @user = user_signed_in? ? current_user.email : "Pls login first"
  end
  
end
