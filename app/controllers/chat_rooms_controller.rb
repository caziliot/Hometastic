class ChatRoomsController < ApplicationController
  before_action :authenticate_user!

  def show
    @chat_room = ChatRoom.find(params[:id])
    @flat = Flat.find(params[:flat_id])
    @message = Message.new
  end
end
