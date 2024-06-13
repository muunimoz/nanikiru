class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :search]
  # before_action :is_matching_login_user, only: [:edit, :update]
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end
  
  def index
    @posts = Post.all
  end
  
  def search
    @posts = Post.search(params[:keyword], params[:area_id], params[:temperature_id])
  end
  
  def show
    @post = Post.find(params[:id])
    @user = @post.user
    favorites = Favorite.where(post_id: @post.id).pluck(:user_id)
    @favorite_users = User.find(favorites)
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post.id)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to user_path(user.id)
  end
  
  private
  
  def post_params
    params.require(:post).permit(:image, :text, :area_id, :temperature_id )
  end
  
  # def is_matching_login_user
  #   user = User.find(params[:id])
  #   unless user.id == current_user.id
  #     redirect_to posts_path
  #   end
  # end
  
end