class BooksController < ApplicationController
  before_action :load_book, only: :show

  def show
    get_reviews = @book.reviews
    @category_name = @book.category.name
    @build_review =  get_reviews.build
    @reviews = get_reviews.latest.includes(:user).paginate page: params[:page],
      per_page: Settings.per_page
    @avg_rating = get_reviews.average(:rate)
      .present? ? get_reviews.average(:rate) : 0
  end

  private
  def load_book
    @book = Book.find_by id: params[:id]
    if @book.nil?
      flash[:danger] = t "book_nil"
      redirect_to root_path
    end
  end
end
