class Flat < ApplicationRecord
  belongs_to :user
  has_many :chatrooms
  has_many :booking_requests

  has_many :available_months, dependent: :destroy
  has_many :messages, through: :chatrooms

  has_many :reviews, through: :booking_requests

  has_many :amenities

  validates :address, presence: true
  validates :price, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :city, presence: true

  # validates :photos, presence: true *temporarily commented for testing purposes
  include PgSearch::Model
  pg_search_scope :search_by_name_date_price_direction_city,
    against: [ :address, :price ],
    using: {
      tsearch: { prefix: true }
    }

  def available?(date_s)
    return available_months.find_by(month_year: date_s, taken: true).nil?
  end
  # validates :photos, presence: true *temporarily commented for testing purposes

end
