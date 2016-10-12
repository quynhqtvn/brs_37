class ReviewsController < ApplicationController
  before_action :load_book, only: :create
  before_action :load_review, only: [:destroy, :edit, :update]

  def create
    @review = @book.reviews.new review_params
    @review.save
    respond_to do |format|
      format.js
    end
  end

  def edit
  end

  def destroy
    @review.destroy
    respond_to do |format|
      format.js
    end
  end

  def update
    if @review.update_attributes review_params
      flash[:success] = t "profile_updated"
      redirect_to @book
    else
      render :edit
    end
  end

  private
  def review_params
    params.require(:review).permit(:title, :content, :rate)
      .merge user_id: current_user.id
  end

  def load_book
    @book = Book.find_by id: params[:book_id]
    if @book.nil?
      flash[:danger] = t "book_nil"
      redirect_to root_path
    end
  end

  def load_review
    @review = Review.find_by id: params[:id]
    unless @review
      flash[:danger] = t "review.not_found"
      redirect_to @book
    end
  end
end
