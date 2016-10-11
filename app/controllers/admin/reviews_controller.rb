class Admin::ReviewsController < ApplicationController
  layout "admin"
  before_action :logged_in_user, :verify_admin
  before_action :load_review, except: :index

  def index
    @reviews = Review.latest.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def destroy
    if @review.destroy
      flash[:success] = t "review.deleted"
    else
      flash[:danger] = t "review.delete_error"
    end
    redirect_to admin_reviews_path
  end

  private
  def review_params
    params.require(:review).permit :user_id, :book_id, :title, :content, :rake
  end
end
