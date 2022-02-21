class ChatsController < ApplicationController
  def show
    @chat = Chat.find(params[:id])
  end

  private

  def chat_params
    params.require(:message).permit(:content)
  end
end
