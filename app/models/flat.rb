class Flat < ApplicationRecord
  belongs_to :user
  has_many :chatrooms
  has_many :booking_requests
  has_many :messages, through: :chatrooms
  has_many :reviews, through: :booking_requests

  validates :address, presence: true
  validates :price, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :city, presence: true
  validates :name, presence: true
  #validates :photos, presence: true *temporarily commented for testing purposes
end
