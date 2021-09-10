class UsersController < ApplicationController
  def index
    @all_users = User.all
    @new_book = current_user.books.new
  end
  
  def show
    @user = User.find(params[:id])
    @new_book = @user.books.new
    @all_books = @user.books.all
  end
  
  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user)
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end
  
  def after_sign_up_path_for(resource)
    redirect_to user_path(resource), notice: "Welcome! You have signed up successfully."
  end
  
  def follows
    @new_book = current_user.books.new
    @user = User.find(params[:id])
    @users = @user.following_user
  end

  def followers
    @new_book = current_user.books.new
    @user = User.find(params[:id])
    @users = @user.follower_user
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
