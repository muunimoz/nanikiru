class Public::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.where(is_draft: false).page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end
  
  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
    @posts = @user.posts.page(params[:page])
  end
  
  def check
    @user = current_user
  end
  
  def withdraw
    @user = current_user
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
  
  def draft
    @user = current_user
    @posts =@user.posts.where(is_draft: true)
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:profile_image, :name)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end
end
