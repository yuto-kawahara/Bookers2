class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(comment_params)
    @book_comment.book_id = @book.id
    @book_comment.save
    @book = @book.reload
    @book.create_notification_comment!(current_user, @book_comment.id)
    @book_comment = BookComment.new
    # redirect_to book_path(book_comment.book_id)
  end

  def destroy
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.find_by(id: params[:id], book_id: @book.id)
    @book_comment.destroy
    @book = @book.reload
    @book_comment = BookComment.new
    # redirect_to book_path(book_comment.book_id)
  end
  
  private
  
  def comment_params
    params.require(:book_comment).permit(:comment)
  end
end
