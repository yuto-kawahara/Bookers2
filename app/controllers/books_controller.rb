class BooksController < ApplicationController
  def index
    @all_users = User.all
    @all_books = Book.all
    @new_book = current_user.books.new
  end
  
  def show
    @user = Book.find(params[:id]).user
    @new_book = @user.books.new
    @book = Book.find(params[:id])
  end
  
  def create
    @new_book = current_user.books.new(book_params)
    if @new_book.save
      redirect_to book_path(@new_book.id), notice: "You have created book successfully."
    else
      @all_books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
      render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  
  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
