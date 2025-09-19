class RegistrationsController < ApplicationController
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
  
      if @user.save
        session[:user_id] = @user.id  # Automatically log in after registration
        redirect_to root_path, notice: "Welcome, #{@user.username}!"
      else
        flash.now[:alert] = @user.errors.full_messages.join(", ")  # Display error messages
        render :new
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:username, :email_address, :password, :password_confirmation)
    end
  end
  