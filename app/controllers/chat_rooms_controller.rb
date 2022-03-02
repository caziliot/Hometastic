class ChatRoomsController < ApplicationController
  before_action :authenticate_user!

  def show
    @chat_room = ChatRoom.find(params[:id])
    @flat = Flat.find(params[:flat_id])
    @message = Message.new
  end

  def create
    @flat = Flat.find(params[:flat_id])
    @chat_room = ChatRoom.new(flat: @flat)
    if @chat_room.save
      redirect_to flat_chat_room_path(@flat, @chat_room)
    else
      redirect_to flat_path(@flat)
    end
  end

  def self.find_chat(flat, user)
    flat.chat_rooms.joins(:messages).where(messages: {user_id: user.id}).distinct
  end

end
