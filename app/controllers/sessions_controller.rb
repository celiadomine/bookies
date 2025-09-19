class SessionsController < ApplicationController
    def new
      # Render the login form
    end
  
    def create
      @user = User.find_by(email_address: params[:email_address])
  
      if @user && @user.authenticate(params[:password])
        # Set session with user_id after successful login
        session[:user_id] = @user.id
        redirect_to root_path, notice: "Logged in successfully!"
      else
        flash.now[:alert] = "Invalid credentials"
        render :new
      end
    end
  
    def destroy
        reset_session
        redirect_to root_path, notice: "Logged out successfully!"
    end
  end
  