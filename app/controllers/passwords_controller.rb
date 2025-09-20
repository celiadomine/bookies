class PasswordsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email_address: params[:email_address])

    if @user.present?
      # Generate a secure token and a timestamp
      @user.password_reset_token = SecureRandom.hex(20)
      @user.password_reset_sent_at = Time.now
      @user.save!

      # Send the email with the reset link
      PasswordMailer.with(user: @user).reset.deliver_now
    end

    redirect_to root_path, notice: "If an account with that email was found, a password reset link has been sent."
  end

  def edit
    @user = User.find_by(password_reset_token: params[:token])

    if @user.nil? || @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_path, alert: "The password reset link is invalid or has expired."
    end
  end

  def update
    @user = User.find_by(password_reset_token: params[:token])

    if @user.nil?
      redirect_to new_password_path, alert: "The password reset link is invalid or has expired."
    elsif @user.update(password_params)
      redirect_to login_path, notice: "Your password has been reset successfully."
    else
      render :edit
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end