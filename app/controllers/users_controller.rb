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
    @notifications = current_user.notifications if current_user
  end

  def add_friend
    u1 = User.find(params[:current_user])
    u2 = User.find(params[:pending_user])
    u1.accept_request(u2)
    flash.notice = "#{u2.name} is now your friend!"
    redirect_to notifications_path
  end

  def reject_request
    u1 = User.find(params[:current_user])
    u2 = User.find(params[:pending_user])
    u1.reject_request(u2)
    redirect_to notifications_path
  end

  def send_request
    u1 = User.find(params[:current_user])
    u2 = User.find(params[:pending_user])
    u1.send_request(u2)
    flash.notice = " Your friend request has been sent to #{u2.name}!"
    redirect_to users_path
  end
end
