class FavoritesController < ApplicationController
  before_action :require_user_logged_in

  def create
    @book = Book.find(params[:book_id])
    current_user.favorite(@book)
    render 'favorites/reload_button'
  end

  def destroy
    @book = Book.find(params[:book_id])
    current_user.unfavorite(@book)
    render 'favorites/reload_button'
  end
end