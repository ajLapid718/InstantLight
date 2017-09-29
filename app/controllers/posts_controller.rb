class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy, :like]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :owned_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.order("created_at DESC").page(params[:page])
  end

  def show
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = "Your post has been created!"
      redirect_to posts_path
    else
      flash.now[:alert] = "Update failed. Please check the form."
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post successfully updated."
      redirect_to @post
    else
      flash.now[:alert] = "Update failed. Please check the form."
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = "Post successfully deleted."
      redirect_to posts_path
    else
      flash.now[:alert] = "Post was not deleted; something went wrong."
    end
  end

  def like
    if @post.liked_by current_user
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path) } # { redirect_to :back} # Might have to do the fallback redirect
        format.js
      end
    end
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:caption, :image)
  end

  def owned_post
    unless current_user == @post.user
      flash[:alert] = "That post doesn't belong to you!"
      redirect_to root_path
    end
  end
end
