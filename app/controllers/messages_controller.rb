class MessagesController < ApplicationController
  def create
    # エントリー情報から現在ログイン中のユーザーか、ルームIDが一致しているか判定
    if Entry.where(:user_id => current_user.id, :room_id => params[:message][:room_id]).present?
      # メッセージを作成
      @message = Message.create(params.require(:message).permit(:user_id, :content, :room_id).merge(:user_id => current_user.id))
      redirect_to room_path(@message.room_id)
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
