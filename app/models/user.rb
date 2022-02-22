class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :flats
  has_many :booking_requests #Outgoing booking requests, booking as a customer
  has_many :messages
  has_many :chatrooms, through: :flats
  has_many :booking_as_owner, through: :flats, source: :booking_requests #Bookings incoming, to my flat

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true
end
