class SearchesController < ApplicationController
  def index
  end
  def search
    @model = params[:search_model]
    method = params[:search_method]
    @word = params[:search_word]

    if @model == "User"
      @result = select(User,method,@word,"name")
    else
      @result = select(Book,method,@word,"title")
    end
    @all_users = User.all
    @new_book = current_user.books.new
    render :index
  end

  def select(model,method,word,column)
    if method == "forward_match"
      result = model.where("#{column} LIKE?", "#{word}%")
    elsif method == "backward_match"
      result = model.where("#{column} LIKE?", "%#{word}")
    elsif method == "perfect_match"
      result = model.where("#{column} LIKE?", "#{word}")
    elsif method == "partial_match"
      result = model.where("#{column} LIKE?", "%#{word}%")
    else
      result = mode.all
    end
    return result
  end

end
