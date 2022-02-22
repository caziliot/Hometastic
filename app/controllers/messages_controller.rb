class MessagesController < ApplicationController
  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.chat = @chatroom
    @message.user = current_user
    if @message.save
      redirect_to flat_chat_path(@chatroom, anchor: "message-#{@message.id}")
    else
      render "chatrooms/show"
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
