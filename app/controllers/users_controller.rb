class UsersController < ApplicationController
  def index
    @all_users = User.all
    @new_book = current_user.books.new
  end
  
  def show
    @user = User.find(params[:id])
    @new_book = @user.books.new
    @all_books = @user.books.all
    # 現在ログイン中のユーザーのエントリー情報を取得
    @currentUserEntry=Entry.where(user_id: current_user.id)
    # 他ユーザーのエントリー情報を取得
    @userEntry=Entry.where(user_id: @user.id)
    # 現在ログイン中の詳細画面でない場合
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          # 現在ログイン中のユーザーと訪問先のユーザーのルームIDが同じの場合
          if cu.room_id == u.room_id then
            # ルームへの入室許可を出す
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      # まだルームIDが発行されていない場合
      unless @isRoom
        # 新しくルームとエントリー情報を作成する
        @room = Room.new
        @entry = Entry.new
      end
    end
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
