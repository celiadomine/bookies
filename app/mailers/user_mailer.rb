class UserMailer < ApplicationMailer
  # This method sends the confirmation email to the user's new email address
  def confirmation_email
    @user = params[:user]
    @token = params[:token]

    mail(to: @user.unconfirmed_email, subject: "Confirm your new email address")
  end
end