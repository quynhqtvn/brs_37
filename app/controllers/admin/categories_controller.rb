class Admin::CategoriesController < ApplicationController
  layout "admin"
  before_action :logged_in_user
  before_action :verify_admin

  def index
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "category.created_successfull"
      redirect_to admin_root_path
    else
      render :new
    end
  end

  private
  def category_params
    params.require(:category).permit :name
  end
end
