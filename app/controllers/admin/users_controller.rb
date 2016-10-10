class Admin::UsersController < ApplicationController
  layout "admin"
  before_action :logged_in_user, :verify_admin

  def index
    @users = User.latest.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def destroy
    if @user.destroy
      flash[:success] = "User deleted"
      redirect_to admin_users_path
    else
      flash[:danger] = "Delete error"
      redirect_to admin_users_path
    end
  end
end
