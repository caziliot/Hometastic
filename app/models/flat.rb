class Flat < ApplicationRecord
  belongs_to :user
  has_many :chats
  has_many :booking_requests
  has_many :messages, through: :chats
  has_many :reviews, through: :booking_requests

  validates :address, presence: true
  validates :price, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :city, presence: true
  #validates :photos, presence: true *temporarily commented for testing purposes
  include PgSearch::Model
  pg_search_scope :search_by_name_date_price_direction_city,
    against: [ :address, :price ],
    using: {
      tsearch: { prefix: true }
    }
end
