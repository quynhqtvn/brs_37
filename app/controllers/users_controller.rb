class UsersController < ApplicationController
  before_action :logged_in_user, only: :index
  before_action :load_user, only: [:show, :edit, :update]
  before_action :verify_user, only: [:edit, :update, :show]

  def index
    @users = User.recent.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
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

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = t "profile_updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :image
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "please_login"
      redirect_to login_url
    end
  end

  def verify_user
    @user = User.find(params[:id])
    if @user.nil?
      flash[:notice] = t "user_not_found"
      redirect_to root_path
    end
    redirect_to root_path unless @user == current_user
  end

  def verify_admin
    redirect_to root_path unless current_user.admin?
  end

  def load_user
    @user = User.find_by params[:id]
    if @user.nil?
      flash[:notice] = t "user_not_found"
      redirect_to root_path
    end
  end
end
