class BookCommentsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: :destroy

  def create
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.build(book_comment_params)
    if @book_comment.save
    else
      render 'redo'
    end
  end

  def destroy
    @book_comment.destroy
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment).merge(book_id: params[:book_id])
  end

  def correct_user
    @book_comment = current_user.book_comments.find_by(id: params[:id])
    redirect_to root_url unless @book_comment
  end
end
