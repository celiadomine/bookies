# app/controllers/profiles_controller.rb

class ProfilesController < ApplicationController
  # Alle Aktionen erfordern einen eingeloggten Benutzer
  before_action :authenticate_user!
  
  # Setze @user für die Aktionen, die das Profil des eingeloggten Users bearbeiten
  before_action :set_current_user_profile, only: [:show, :edit, :update, :activities]

  # Die confirm_email Action muss separat den User über die ID finden können
  before_action :set_user_by_id, only: [:confirm_email]

  def show
    # @user ist bereits durch set_current_user_profile gesetzt
  end

  def edit
    # @user ist bereits durch set_current_user_profile gesetzt
  end

  def update
    # @user ist bereits durch set_current_user_profile gesetzt
    
    if user_params[:unconfirmed_email].present? && user_params[:unconfirmed_email] != @user.email_address
      @user.unconfirmed_email = user_params[:unconfirmed_email]
      @user.confirmation_token = SecureRandom.urlsafe_base64
      @user.confirmation_sent_at = Time.now
      
      if @user.save
        # Korrekter Pfad-Helfer für die confirm_email member-Route
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
    # @user ist durch set_user_by_id gesetzt
    
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

  def activities
    # @user ist current_user
    # Ruft Aktivitäten für den aktuell eingeloggten Benutzer ab
    @activities = PublicActivity::Activity.order("created_at desc").where(owner: @user)
  end

  private
  
  def set_current_user_profile
    @user = current_user
  end
  
  def set_user_by_id
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Profil nicht gefunden."
  end

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :unconfirmed_email)
  end
end