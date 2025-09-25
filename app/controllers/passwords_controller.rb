class PasswordsController < ApplicationController
  include Rails.application.routes.url_helpers 
  def new
  end

  def create
    @user = User.find_by(email_address: params[:email_address])
  
    if @user.present?
      # Generate a secure token and a timestamp
      token = SecureRandom.hex(20)
      @user.password_reset_token = token
      @user.password_reset_sent_at = Time.now
      @user.save!
  
      reset_link = edit_password_url(token: token, host: request.host_with_port)
  
      Rails.logger.debug "--------------------------------------------------------"
      Rails.logger.debug "PASSWORD RESET LINK: #{reset_link}"
      Rails.logger.debug "--------------------------------------------------------"      
    end
  
    redirect_to root_path, notice: "If an account with this email address was found, a link to reset your password has been sent. Please check your terminal."
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