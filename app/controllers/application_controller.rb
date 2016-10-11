class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  protected
  def verify_admin
    redirect_to root_path unless current_user && current_user.admin?
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "please_login"
      redirect_to login_url
    end
  end

  def load_book
    @book = Book.find_by id: params[:id]
    if @book.nil?
      flash[:notice] = t "book.not_found"
      redirect_to admin_root_path
    end
  end

  def load_review
    @review = Review.latest.find_by id: params[:id]
    if @review.nil?
      flash[:notice] = t "review.not_found"
      redirect_to admin_root_path
    end
  end

  def load_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:notice] = t "user_not_found"
      redirect_to root_path
    end
  end
end
