class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :flats
  has_many :booking_requests #Outgoing booking requests, booking as a customer
  has_many :messages
  has_many :chats, through: :flats
  has_many :booking_as_owner, through: :flats, source: :booking_requests #Bookings incoming, to my flat
end
