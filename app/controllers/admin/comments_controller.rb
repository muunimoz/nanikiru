class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
      @comments = Comment.all
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end
  
  def update
    comment = Comment.find(params[:id])
    comment.update(comment_params)
      redirect_to admin_comments_path
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :comment )
  end
end

