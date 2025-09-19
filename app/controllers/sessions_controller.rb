class SessionsController < ApplicationController
    def new
      # Render the login form
    end
  

    def create
        if user = User.authenticate_by(email_address: params[:email_address], password: params[:password])
          session[:user_id] = user.id
          redirect_to root_path, notice: "Erfolgreich eingeloggt!"
        else
          flash.now[:alert] = "Ungültiger Benutzername oder Passwort."
          render :new
        end
      end
  
    def destroy
        reset_session
        redirect_to root_path, notice: "Logged out successfully!"
    end
  end
  