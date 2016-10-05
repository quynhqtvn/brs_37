class StaticPagesController < ApplicationController
  before_action :load_categories
  before_action :load_tags

  def index
    case
    when params[:tag].present?
      @tag = Tag.find_by name: params[:tag]
      handle_object_nil @tag
      @books = @tag.books
    when params[:category].present?
      @category = Category.find_by name: params[:category]
      handle_object_nil @category
      @books = @category.books
    else
      @books = Book.all
    end
    @books = @books.latest.paginate page: params[:page],
      per_page: Settings.per_page
  end

  private
  def load_categories
    @categories = Category.all
  end

  def load_tags
    @tags = Tag.all
  end

  def handle_object_nil object
    if object.nil?
      flash[:danger] = t "found_nil"
      redirect_to root_path
    end
  end
end
