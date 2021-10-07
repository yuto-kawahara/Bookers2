class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @book.favorites.create(user_id: current_user.id)
    @book = @book.reload
    @book.create_notification_favorite!(current_user)
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = @book.favorites.find_by(user_id: current_user.id)
    favorite.destroy
    @book = @book.reload
  end
  
end
