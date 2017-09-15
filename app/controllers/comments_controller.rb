class CommentsController < ApplicationController
  before_action :find_post

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])

    if @comment.save
      redirect_to @post
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
