class ChatsController < ApplicationController

before_action :reject_non_related, only: [:show]

def show
 @user = User.find(params[:id])                                             #相手のuserの情報
 rooms = current_user.user_rooms.pluck(:room_id)                            #特定のカラムのデータだけ欲しいのでpluck使う。ログイン中のuserが持ってるroom.idを持ってくる。
 user_rooms = UserRoom.find_by(user_id: @user.id,room_id:rooms)             #相手の中で自分と同じroomを持っている人を探す
  unless user_rooms.nil?                                                    #user_roomが空ではない限り、
   @room = user_rooms.room
  else
   @room = Room.new
   @room.save
   UserRoom.create(user_id: current_user.id, room_id: @room.id)
   UserRoom.create(user_id: @user.id, room_id: @room.id)
  end
   @chats = @room.chats
   @chat = Chat.new(room_id: @room.id)
end

 def create
  @chat = current_user.chats.new(chat_params)
  @chat.save
  @chats =  current_user.chats
 end

 private

 def chat_params
  params.require(:chat).permit(:message, :room_id)
 end

 def reject_non_related
   user = User.find(params[:id])
   unless current_user.followed_by?(user) && user.followed_by?(current_user)
   redirect_to books_path
   end
 end

end
