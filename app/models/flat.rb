class Flat < ApplicationRecord
  belongs_to :user
  has_many :chats
  has_many :booking_requests
  has_many :messages, through: :chats
end
