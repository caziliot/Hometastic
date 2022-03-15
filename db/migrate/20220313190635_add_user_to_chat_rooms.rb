class AddUserToChatRooms < ActiveRecord::Migration[6.1]
  def change
    add_reference :chat_rooms, :user, null: false, foreign_key: true
  end
end
