class PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    post = Post.new(post_params)
    post.save
    redirect_to posts_path
  end
  
  def index
    @posts = Post.all
  end

  def show
  end

  def edit
  end
  
  def update
  end

  def destroy
  end
  
end
