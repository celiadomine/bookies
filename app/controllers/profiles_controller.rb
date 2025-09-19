class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

def update
  @user = current_user
  
  if user_params[:unconfirmed_email].present? && user_params[:unconfirmed_email] != @user.email_address
    @user.unconfirmed_email = user_params[:unconfirmed_email]
    @user.confirmation_token = SecureRandom.urlsafe_base64
    @user.confirmation_sent_at = Time.now
    
    if @user.save
      confirmation_link = confirm_email_profile_url(@user, token: @user.confirmation_token)
      Rails.logger.debug "--------------------------------------------------------"
      Rails.logger.debug "Email Confirmation Link: #{confirmation_link}"
      Rails.logger.debug "--------------------------------------------------------"
      
      redirect_to profile_path, notice: "Ein Bestätigungslink wurde an Ihre neue E-Mail-Adresse gesendet. Bitte überprüfen Sie Ihr Terminal um die Mail endgültig zu ändern."
    else
      render :edit
    end
  elsif @user.update(user_params.except(:unconfirmed_email))
    redirect_to profile_path, notice: "Profil erfolgreich aktualisiert!"
  else
    render :edit
  end
end

def confirm_email
  @user = User.find(params[:id])
  
  if @user.confirmation_token == params[:token] && @user.confirmation_sent_at > 24.hours.ago
    ActiveRecord::Base.transaction do
      @user.update!(email_address: @user.unconfirmed_email)

      @user.update!(unconfirmed_email: nil, confirmation_token: nil, confirmation_sent_at: nil)
    end
    
    redirect_to profile_path, notice: "Ihre E-Mail-Adresse wurde erfolgreich aktualisiert!"
  else
    redirect_to profile_path, alert: "Ungültiger oder abgelaufener Bestätigungslink."
  end
end
  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :unconfirmed_email)
  end
end