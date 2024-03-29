# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]


  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    unauthenticate_user(current_user[:id]) 

    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end

  private

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute, :username])

    puts "============================"
    puts params[:user]
    puts "============================"

    if User.find_by(email: params[:user][:email]).present?
      
      redirect_to new_user_registration_url, 
      notice: "email #{params[:user][:email]} already in use"
      
    end


  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute, :username, :avatar])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    # puts "============================"
    # puts resource.inspect
    # puts "============================"

    # User sidekiq/redis to send email while resetting password
    begin 
      Job3Job.perform_later(resource)

      #validate cable connection
      authenticate_user(resource[:id])
    rescue =>err 
      p err 
    end

    super(resource)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end

end
