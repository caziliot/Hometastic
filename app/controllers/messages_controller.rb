class MessagesController < ApplicationController
  def create
    @chat = Chatroom.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.chat = @chat
    @message.user = current_user
    if @message.save
      redirect_to flat_chat_path(@chat, anchor: "message-#{@message.id}")
    else
      render "chats/show"
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
