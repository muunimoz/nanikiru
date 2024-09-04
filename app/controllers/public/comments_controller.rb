class Public::CommentsController < ApplicationController
  
  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = post.id
    if comment.save
      redirect_to post_path(post.id)
    else
      redirect_to post_path(post.id),alert:"エラーが発生しました"
    end
  end
  
  def destroy
    comment = Comment.find(params[:id])
    post_id = comment.post_id
    comment.destroy
    redirect_to post_path(post_id)
  end
  
  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
