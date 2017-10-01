class CommentsController < ApplicationController
  before_action :find_post # The before_action invokes the private method #find_post to ensure that we are creating a comment on the porper corresponding post

  def index
    @comments = @post.comments.order("created_at ASC")

    respond_to do |format|
      format.html { render layout: !request.xhr? }
    end
  end

  def create
    @comment = @post.comments.build(comment_params) # @post.comments.build(comment_params) makes use of the has_many relationship that the post model has and then builds a comment there, with the post_id assigned to the comment upon creation
    @comment.user_id = current_user.id # set the foreign key (user_id) of the comment to the current user's id so that the comment belongs to a user

    if @comment.save
      create_notification @post, @comment
      respond_to do |format|
       format.html { redirect_to root_path }
       format.js
      end
    else
      flash[:alert] = "Check the comment form, something went horribly wrong!"
      render root_path # not necessarily render :new because we don't want a comment form out there on its own view without it being attached to the post
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id]) # Due to the nature of comments being built or found through their association with the post model, this is the way to accurately reference the comment at hand
    if @comment.user_id == current_user.id
      @comment.destroy
      respond_to do |format|
       format.html { redirect_to root_path }
       format.js
      end
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def create_notification(post)
    return if post.user.id == current_user.id
    Notification.create(user_id: post.user.id, notified_by_id: current_user.id, post_id: post.id, comment_id: comment.id, notice_type: 'comment')
  end
end
