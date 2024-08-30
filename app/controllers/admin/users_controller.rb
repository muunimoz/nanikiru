class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
      @users = User.all
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    user = User.find(params[:id])
    user.update(user_params)
      redirect_to admin_users_path
  end
  
  def withdraw
    @user.update(is_active: false)
    reset_session
    redirect_to admin_users_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:post_image, :name, :is_active )
  end
end
