class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user  # Only the current user should see their profile
  end

  def edit
    @user = current_user  # Fetch the current user to edit their profile
  end

  def update
    @user = current_user  # Fetch the current user to update their profile
    if @user.update(user_params)
      redirect_to profile_path, notice: "Profile updated successfully!"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email_address, :password, :password_confirmation)
  end
end
