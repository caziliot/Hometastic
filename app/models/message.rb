class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat
  validates :content, presence: true, message: "can't be blank"
end
