class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @friends = @user.friend_list
  end

  def notifications
    if current_user
      @notifications = current_user.notifications
    end
  end

  def add_friend
    u1 = User.find(params[:current_user])
    u2 = User.find(params[:pending_user])
    u1.accept_request(u2)
    redirect_to notifications_path
  end
end
