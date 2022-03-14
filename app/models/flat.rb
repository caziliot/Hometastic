class Flat < ApplicationRecord
  belongs_to :user
  has_many :chat_rooms
  has_many :booking_requests
  has_many :available_months, dependent: :destroy
  has_many :messages, through: :chatrooms
  has_many :reviews, through: :booking_requests
  has_many :amenities, dependent: :destroy
  has_many_attached :photos
  validates :address, presence: true
  validates :price, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :city, presence: true
  #validates :photos, presence: true
  validates :name, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch::Model
  pg_search_scope :search_by_name_date_price_direction_city,
    against: [ :address, :price, :name ],
    using: {
      tsearch: { prefix: true }
    }

  def available?(date_s)
    month = available_months.find_by(month_year: date_s)
    return month.nil? ? false : !month.taken
  end

  def available_between?(date_s, date_e)
    months = available_months.select do |am|
      am.month_year.to_date >= date_s.to_date && am.month_year.to_date <= date_e.to_date && !am.taken
    end
    return months.any?
  end



  def review_average
    sum = 0.0
    reviews.each do |r|
      sum+= r.rating
    end
    return (sum.to_f/reviews.size).round(1) if reviews.any?
  end
end
