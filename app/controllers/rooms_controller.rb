class RoomsController < ApplicationController
  def create
    # ルームを新しく作成
    @room = Room.create
    # 現在ログイン中のユーザーのエントリー情報の作成
    @entry1 = Entry.create(:room_id => @room.id, :user_id => current_user.id)
    # 訪問先ユーザーのエントリー情報の作成
    @entry2 = Entry.create(entry_params.merge(:room_id => @room.id))
    redirect_to room_path(@room.id)
  end
  
  def show
    # 作成したルームの情報を取得
    @room = Room.find(params[:id])
    # エントリー情報に現在ログイン中のユーザーのIDとルームIDが登録されているか確認
    if Entry.where(:user_id => current_user.id, :room_id => @room.id).present?
      # ルーム内のメッセージ内容を全て取得
      @messages = @room.messages
      # 新しくメッセージを送信するために空のメッセージを発行
      @message = Message.new
      # 現在ルーム内にいるユーザーの情報を取得
      @entries = @room.entries
      binding.pry
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def entry_params
    params.require(:entry).permit(:user_id, :room_id)
  end
end
