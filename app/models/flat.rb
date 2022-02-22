class Flat < ApplicationRecord
  belongs_to :user
  has_many :chatrooms
  has_many :booking_requests
  has_many :messages, through: :chatrooms

  validates :address, presence: true
  validates :price, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :city, presence: true
  validates :availability, presence: true
  validates :photos, presence: true
end
