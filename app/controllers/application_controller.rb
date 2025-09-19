class ApplicationController < ActionController::Base
  helper_method :current_user
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Stelle sicher, dass der Benutzer angemeldet ist (nützlich für die geschützten Routen)
  def authenticate_user!
    redirect_to login_path unless current_user
  end
end
