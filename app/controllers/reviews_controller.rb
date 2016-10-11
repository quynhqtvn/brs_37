class ReviewsController < ApplicationController

  def create
    @book = Book.find_by id: params[:book_id]
    @review = @book.reviews.new review_params
    if @review.save
      redirect_to book_path @book
    else
      flash[:danger] = t "review_error"
      redirect_to book_path @book
    end
  end

  private
  def review_params
    params.require(:review).permit(:title, :content, :rate)
      .merge user_id: current_user.id
  end
end
