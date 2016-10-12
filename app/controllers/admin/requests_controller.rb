class Admin::RequestsController < ApplicationController
  layout "admin"
  before_action :logged_in_user, :verify_admin
  before_action :load_request, except: [:new, :index, :create]

  def index
    @requests = Request.latest.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def edit
  end

  def update
    if @request.update_attributes request_params
      flash[:success] = t "request.updated"
      redirect_to admin_requests_path
    else
      flash[:notice] = t "request.update_error"
      render :edit
    end
  end

  def destroy
    if @request.destroy
      flash[:success] = t "request.deleted"
    else
      flash[:danger] = t "request.delete_error"
    end
    redirect_to admin_requests_path
  end

  private
  def request_params
    params.require(:request).permit :user_id, :review_id, :content, :status
  end

  def load_request
    @request = Request.find_by id: params[:id]
    if @request.nil?
      flash[:notice] = t "request.not_found"
      redirect_to admin_root_path
    end
  end
end
