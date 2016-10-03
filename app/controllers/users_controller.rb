class UsersController < ApplicationController
  before_action :logged_in_user, only: :index
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.recent.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
    @user = User.find_by params[:id]
    unless @user
      flash[:notice] = t "user_not_found"
      redirect_to root_path
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "register"
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :image
  end
end
