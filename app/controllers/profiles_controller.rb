class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
    # No need to load @user again; it's already set in the before_action
  end

  def edit
    # @user is set here too, so you can use it in the form
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path, notice: "Profil erfolgreich aktualisiert!"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email_address, :password, :password_confirmation)
  end
end
