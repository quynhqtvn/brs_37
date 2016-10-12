class UsersController < ApplicationController
  before_action :logged_in_user, only: :index
  before_action :verify_user, except: [:index, :new, :create]

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
    if @user.update_attributes user_params
      flash[:success] = t "profile_updated"
      redirect_to @user
    else
      render :edit
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
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:notice] = t "user_not_found"
      redirect_to root_path
    end
  end
end
