class ProfilesController < ApplicationController
  def show
    @posts = User.find_by(username: params[:username])
  end
end
