class ChatRoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @chat_rooms = current_user.all_chats
  end

  def show
    @chat_rooms = current_user.all_chats
    @chat_room = ChatRoom.find(params[:id])
    @flat = Flat.find(params[:flat_id])
    @message = Message.new
  end

  def create
    @flat = Flat.find(params[:flat_id])
    if @flat.find_chat(current_user)
      @chat_room = @flat.find_chat(current_user)
      redirect_to flat_chat_room_path(@flat, @chat_room)
    else
      @chat_room = ChatRoom.new(flat: @flat)
      if @chat_room.save
        redirect_to flat_chat_room_path(@flat, @chat_room)
      else
        redirect_to flat_path(@flat)
      end
    end
  end

  def self.find_chat(flat, user)
    flat.chat_rooms.joins(:messages).where(messages: {user_id: user.id}).distinct
  end

end
