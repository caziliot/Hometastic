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
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: 'chat_rooms/chat_show', locals: { chat_room: @chat_room, flat: @flat, message: @message}, formats: [:html], anchor: "#message-#{@chat_room.messages.last&.id}" }
    end
  end

  def create
    @flat = Flat.find(params[:flat_id])
    @chat_room = ChatRoom.find_by(flat_id: @flat.id, user_id: current_user.id)
    if @chat_room
      redirect_to flat_chat_room_path(@flat, @chat_room, anchor: "message-#{@chat_room.messages.last&.id}")
    else
      @chat_room = ChatRoom.new(flat: @flat, user: current_user)
      if @chat_room.save
        redirect_to flat_chat_room_path(@flat, @chat_room)
      else
        redirect_to flat_path(@flat)
      end
    end
  end


end
