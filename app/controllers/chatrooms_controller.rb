class ChatRoomsController < ApplicationController
  def show
    @chatrooms = Chatrooms.find(params[:id])
  end

  private

  def chatroom_params
    params.require(:message).permit(:content)
  end
end
