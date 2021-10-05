class BooksController < ApplicationController
  impressionist :actions=> [:show], unique: [:impressionable_id, :ip_address]
  def index
    @all_users = User.all
    to  = Time.current.at_end_of_day
    from  = (to - 6.day).at_beginning_of_day
    @all_books = Book.includes(:favorited_users).
      sort {|a,b| 
        b.favorited_users.includes(:favorites).where(created_at: from...to).size <=> 
        a.favorited_users.includes(:favorites).where(created_at: from...to).size
      }
    # binding.pry

    @new_book = current_user.books.new
  end
  
  def show
    @user = Book.find(params[:id]).user
    @new_book = current_user.books.new
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    impressionist(@book, nil, unique: [:impressionable_id, :ip_address])
    # binding.pry
    redirect_to books_path if @book.blank?
  end
  
  def create
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
    if @new_book.save
      redirect_to book_path(@new_book.id), notice: "You have created book successfully."
    else
      @all_books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to books_path
    end
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
