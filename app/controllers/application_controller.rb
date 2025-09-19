class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def authenticate_user!
    redirect_to login_path, alert: "You must be logged in to access this page." unless current_user
  end
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    session[:user_id] = nil
    nil
  end

  def user_not_authorized
    flash[:alert] = "Sie sind nicht berechtigt, diese Aktion auszuführen."
    redirect_back fallback_location: root_path
  end
end