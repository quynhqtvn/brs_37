class BooksController < ApplicationController
  before_action :load_book, only: [:show, :edit, :update]

  def show
    @category_name = @book.category.name
    @build_review =  @book.reviews.build
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
