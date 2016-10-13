class CommentsController < ApplicationController
  before_action :load_review
  before_action :load_comment, except: :create
  before_action :load_book

  def create
    @book = @review.book
    @comment = @review.comments.new review_params
    if @comment.save
      add_activity "comment", @comment.review.book_id
      redirect_to book_path @book
    else
      flash[:danger] = t "create_comment"
      redirect_to book_path @book
    end
  end

  def edit
  end

  def update
    @book = @review.book
    if @comment.update_attributes review_params
      flash[:success] = t "profile_updated"
      redirect_to book_path @book
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    remove_activity "comment", @comment.review.book_id
    redirect_to book_path @book
  end

  private
  def review_params
    params.require(:comment).permit(:content).merge user_id: current_user.id
  end

  def load_review
    @review = Review.find_by id: params[:review_id]
    unless @review
      flash[:danger] = t "review.not_found"
      redirect_to root_path
    end
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
    unless @comment
      flash[:danger] = t "comment.not_found"
      redirect_to root_path
    end
  end

  def load_book
    @book = Book.find_by id: params[:book_id]
    unless @book
      flash[:danger] = t "book_nil"
      redirect_to root_path
    end
  end
end
