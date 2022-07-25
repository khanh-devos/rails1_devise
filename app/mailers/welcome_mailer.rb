class WelcomeMailer < ApplicationMailer
    default from: 'khanhcisme@gmail.com'

    def welcome_email
        @user = params[:user]

        # puts "++++++++++++++++++++++++++++"
        # puts @user.email
        # puts "++++++++++++++++++++++++++++"

        @url  = 'http://127.0.0.1:3000/users/sign_in'
        
        mail(to: @user.email, subject: 'Welcome to Ruby', )
    end

    private

    # def create_reset_password_token(@user)
    #     raw, hashed = Devise.token_generator.generate(User, :reset_password_token)
    #     @token = raw
    #     @user.reset_password_token = hashed
    #     @user.reset_password_sent_at = Time.now.utc
    #     @user.save
    # end
end
