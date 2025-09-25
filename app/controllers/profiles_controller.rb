# app/controllers/profiles_controller.rb

class ProfilesController < ApplicationController
  # All actions require a logged-in user
  before_action :authenticate_user!
  
  # Set @user for actions that modify the currently logged-in user's profile
  before_action :set_current_user_profile, only: [:show, :edit, :update, :activities]

  # The confirm_email action must find the user by ID separately
  before_action :set_user_by_id, only: [:confirm_email]

  def show
    # @user is set by set_current_user_profile
  end

  def edit
    # @user is set by set_current_user_profile
  end

  def update
    # @user is set by set_current_user_profile
    
    if user_params[:unconfirmed_email].present? && user_params[:unconfirmed_email] != @user.email_address
      @user.unconfirmed_email = user_params[:unconfirmed_email]
      @user.confirmation_token = SecureRandom.urlsafe_base64
      @user.confirmation_sent_at = Time.now
      
      if @user.save
        # Correct path helper for the confirm_email member route
        confirmation_link = confirm_email_profile_url(@user, token: @user.confirmation_token)
        Rails.logger.debug "--------------------------------------------------------"
        Rails.logger.debug "Email Confirmation Link: #{confirmation_link}"
        Rails.logger.debug "--------------------------------------------------------"
        
        redirect_to profile_path, notice: "A confirmation link has been sent to your new email address. Please check your terminal to finalize the email change."
      else
        render :edit
      end
    elsif @user.update(user_params.except(:unconfirmed_email))
      redirect_to profile_path, notice: "Profile successfully updated!"
    else
      render :edit
    end
  end

  def confirm_email
    # @user is set by set_user_by_id
    
    if @user.confirmation_token == params[:token] && @user.confirmation_sent_at > 24.hours.ago
      ActiveRecord::Base.transaction do
        @user.update!(email_address: @user.unconfirmed_email)

        @user.update!(unconfirmed_email: nil, confirmation_token: nil, confirmation_sent_at: nil)
      end
      
      redirect_to profile_path, notice: "Your email address has been successfully updated!"
    else
      redirect_to profile_path, alert: "Invalid or expired confirmation link."
    end
  end

  def activities
   
    if current_user.admin?
      @activities = PublicActivity::Activity.order(created_at: :desc)
    else
      @activities = PublicActivity::Activity.order(created_at: :desc).where(owner: current_user)
    end
  end

  private
  
  def set_current_user_profile
    @user = current_user
  end
  
  def set_user_by_id
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Profile not found."
  end

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :unconfirmed_email)
  end
end