class Admin::BooksController < ApplicationController
  extend DatabaseQuery
  layout "admin"
  before_action :logged_in_user, :verify_admin
  before_action :load_book, except: [:new, :index, :create]
  before_action :load_data, only: [:edit, :new]

  def index
    @books = Book.sort_by_name.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = t "book.created_successfull"
      redirect_to admin_books_path
    else
      flash[:danger] = t "book.create_error"
      render :new
    end
  end

  def edit
  end

  def update
    if @book.update_attributes book_params
      flash[:success] = t "book.updated_successfull"
      redirect_to admin_books_path
    else
      flash[:danger] = t "book.update_error"
      render :edit
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = t "book.deleted"
    else
      flash[:danger] = t "book.delete_error"
      redirect_to admin_books_path
    end
  end

  private
  def book_params
    params.require(:book).permit :title, :alias, :description, :author,
      :num_pages, :publish_date, :category_id, :book_img, tag_ids: []
  end

  def load_data
    @categories = Category.order :name
    @tags = Tag.all.order :name
  end
end
