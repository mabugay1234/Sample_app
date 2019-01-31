class FollowingsController < ApplicationController
  before_action :logged_in_user

  def show
    @title = t ".following"
    @user  = User.find_by id: params[:id]
    @users = @user.following.page(params[:page]).per Settings.user_per_page
    render "users/show_follow"
  end
end
