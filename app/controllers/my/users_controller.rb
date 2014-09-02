class My::UsersController < ApplicationController
  respond_to :html
  responders :flash

  before_filter :set_user

  def show
    respond_with @user
  end

  def edit
    respond_with @user
  end

  def update
    location = if @user.update user_profile_params
      my_profile_path
    else
      edit_my_profile_path
    end
    respond_with @user, location: location
  end

  private

  def set_user
    @user = current_user.decorate
    authorize! :manage, @user
  end

  def user_profile_params
    params.require(:user).permit(:first_name, :last_name, :nickname, :website, :bio, :avatar_image, :avatar_image_cache)
  end
end