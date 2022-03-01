class MessagesController < ApplicationController
  def create
    @chat_room = ChatRoom.find(params[:chat_room_id])
    @message = Message.new(message_params)
    @message.chat_room = @chat_room
    @message.user = current_user
    if @message.save
      ChatRoomChannel.broadcast_to(@chat_room,
        render_to_string(partial: "message", locals: { message: @message }))
    else
      render "chatrooms/show"
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
