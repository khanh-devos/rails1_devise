# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  before_action :modStatus, only: [:destroy]

  after_action :modCookie, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy   
    unauthenticate_user(current_user[:id]) 
    super
  end

  private

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end

  #only exe after create() succeeded 
  def modCookie
    # puts "((((((((((#{params.inspect})))))))))"  #token in params
    authenticate_user(current_user[:id])
  end

  def modStatus
    puts "((((((((((modStatus)))))))))"  #token in params
    current_user.update(status: nil)
  end

end
