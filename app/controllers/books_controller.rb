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

    if (params[:sort] == "new_list")
      @all_books = Book.all.order(created_at: "DESC")
    elsif (params[:sort] == "rank_list")
      @all_books = Book.all.order(evaluation: "DESC")
    else
      @all_books = Book.all
    end    
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
    tag_list = params[:book][:tag_name]
    if @new_book.save
      @new_book.save_tag(tag_list)
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
  
  def search
    @new_book = current_user.books.new
    @tag = Tag.find_by(tag_name: params[:tag_name])
    if @tag.nil?
      redirect_to books_path
    else
      @all_books = @tag.books
      render :index  
    end
  end

  private
  
  def book_params
    params.require(:book).permit(:title, :body, :evaluation)
  end
end
