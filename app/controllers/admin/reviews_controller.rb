class Admin::ReviewsController < ApplicationController
  layout "admin"
  before_action :logged_in_user, :verify_admin
  before_action :load_book, except: :index

  def index
    @reviews = Review.latest.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def destroy
    load_review
    if @review.destroy
      flash[:success] = t "review.deleted"
    else
      flash[:danger] = t "review.delete_error"
    end
    redirect_to admin_book_reviews_path
  end

  private
  def review_params
    params.require(:review).permit :user_id, :book_id, :title, :content, :rake
  end

  def load_review
    @review = @book.reviews.find_by id: params[:id]
    if @review.nil?
      flash[:notice] = t "review.not_found"
      redirect_to admin_root_path
    end
  end
end
