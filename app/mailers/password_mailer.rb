class PasswordMailer < ApplicationMailer
  def reset
    @user = params[:user]
    mail to: @user.email_address, subject: "Password Reset Instructions"
  end
end