class BooksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [ :edit, :update, :destroy ]
  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    @book_comments = @book.book_comments.includes(:user)
  end

  def index
    @book = Book.new
    @books = Book.includes(user: { profile_image_attachment: :blob })
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    @book = current_user&.books&.find_by(id: params[:id])
    redirect_to books_url unless @book
  end
end
