class ProfilesController < ApplicationController
  def show
    @posts = User.find_by(username: params[:username]).posts.order('created_at DESC')
  end
end
