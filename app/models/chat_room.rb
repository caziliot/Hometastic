class ChatRoom < ApplicationRecord
  belongs_to :flat
  has_many :messages, dependent: :destroy
end
