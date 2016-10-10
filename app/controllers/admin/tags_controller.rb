class Admin::TagsController < ApplicationController
  layout "admin"
  before_action :logged_in_user, :verify_admin
  before_action :load_tag, except: [:new, :index, :create]

  def index
    @tags = Tag.sort_by_name.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new tag_params
    if @tag.save
      flash[:success] = t "tag.created_successfull"
      redirect_to admin_root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @tag.update_attributes tag_params
      flash[:success] = t "tag.updated"
    else
      flash[:danger] = t "tag.update_error"
      render :edit
    end
    redirect_to admin_tags_path
  end

  def destroy
    if @tag.destroy
      flash[:success] = t "tag.deleted"
    else
      flash[:danger] = t "tag.delete_error"
    end
    redirect_to admin_tags_path
  end

  private
  def tag_params
    params.require(:tag).permit :name
  end

  def load_tag
    @tag = Tag.find_by id: params[:id]
    if @tag.nil?
      flash[:notice] = t "tag.not_found"
      redirect_to admin_root_path
    end
  end
end
