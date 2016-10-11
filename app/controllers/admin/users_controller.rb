class Admin::UsersController < ApplicationController
  layout "admin"
  before_action :logged_in_user, :verify_admin
  before_action :load_user, only: :destroy

  def index
    @users = User.latest.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def destroy
    if @user.destroy
      flash[:success] = t "user.deleted"
    else
      flash[:danger] = t "user.delete_error"
    end
      redirect_to admin_users_path
  end
end
