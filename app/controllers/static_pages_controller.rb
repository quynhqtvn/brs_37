class StaticPagesController < ApplicationController
  before_action :load_categories

  def home
    if params[:category].present?
      @category = Category.find_by name: params[:category]
      if @category.nil?
        flash[:danger] = t "category_nil"
        redirect_to root_path
      end
    end
    @books = Book.of_category(@category.try(:id)).latest
  end

  private
  def load_categories
    @categories = Category.all
  end
end
