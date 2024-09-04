class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :search]
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @post = Post.new
  end

   def create 
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    post_tags = params[:post][:tags].split(',') if params[:post][:tags]
    if params[:public]
      if @post.save(context: :publicize)
        @post.save_post_tags(post_tags)
        redirect_to post_path(@post.id)
      else
        render :new
      end
    else
      if @post.update(is_draft: true)
        redirect_to user_path(current_user)
      else
        render :new
      end
    end
  end

  def index
    @posts = Post.where(is_draft: false).page(params[:page])
    @tags = Tag.all
  end

  def search
    @posts = Post.search(params[:keyword], params[:area_name], params[:temperature_name])
    @posts = @posts.where(is_draft: false).page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    favorites = Favorite.where(post_id: @post.id).pluck(:user_id)
    @favorite_users = User.find(favorites)
    @comment = Comment.new
    @post_tags = @post.tags
  end

  def edit
    @post = Post.find(params[:id])
    @post_tags = @post.tags.pluck(:name).join(',')
  end

  def update
    @post = Post.find(params[:id])
    if params[:public]
      # 公開時にバリデーションを実施
      # updateメソッドにはcontextが使用できないため、公開処理にはattributesとsaveメソッドを使用する
      @post.attributes = post_params.merge(is_draft: false)
      if @post.save(context: :publicize)
        redirect_to post_path(@post.id)
      else
        @post.is_draft = true
        render :edit
      end
  # ②公開済みの更新の場合
    elsif params[:update]
      @post.attributes = post_params
      if @post.save(context: :publicize)
        redirect_to post_path(@post.id)
      else
        render :edit
      end
  # ③下書きの更新（非公開）の場合
    else
      if @post.update(post_params)
        redirect_to post_path(@post.id)
      else
          render :edit
      end
    end
    plan_tags = params[:plan][:tags].split(',') if params[:plan][:tags]
    if @plan.update(plan_params)
      @plan.tags.destroy_all
      @plan.save_plan_tags(plan_tags)
      redirect_to plan_path(@plan)
    else
      render 'edit'
    end
  end


  #   post = Post.find(params[:id])
  #   post.update(post_params)
  #   redirect_to post_path(post.id)
  # end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to user_path(current_user.id)
  end

  private

  def post_params
    params.require(:post).permit(:image, :text, :area_id, :temperature_id, :is_draft )
  end

  def is_matching_login_user
    post = Post.find(params[:id])
    unless post.user_id == current_user.id
      redirect_to posts_path
    end
  end
end