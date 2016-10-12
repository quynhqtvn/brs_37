class Admin::CommentsController < ApplicationController
  layout "admin"
  before_action :logged_in_user, :verify_admin
  before_action :load_comment, only: :destroy

  def index
    @comments = Comment.latest.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def destroy
    if @comment.destroy
      flash[:success] = t "comment.deleted"
    else
      flash[:danger] = t "comment.delete_error"
    end
    redirect_to admin_comments_path
  end

  private
  def comment_params
    params.require(:comment).permit :user_id, :review_id, :content
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
    if @comment.nil?
      flash[:notice] = t "comment.not_found"
      redirect_to admin_root_path
    end
  end
end
