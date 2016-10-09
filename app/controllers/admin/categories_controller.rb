class Admin::CategoriesController < ApplicationController
  layout "admin"
  before_action :logged_in_user
  before_action :verify_admin
  before_action :load_category, except: [:new, :index, :create]

  def index
    @categories = Category.sort_by_name.paginate page: params[:page],
      per_page: Settings.per_page
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

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "category.updated"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "category.deleted"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "category.delete_error"
      redirect_to admin_root_path
    end
  end

  private
  def category_params
    params.require(:category).permit :name, :alias
  end

  def load_category
    @category = Category.find_by params[:id]
    if @category.nil?
      flash[:notice] = t "category.not_found"
      redirect_to admin_root_path
    end
  end
end
