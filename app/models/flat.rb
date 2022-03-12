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

  def find_chat(user_id)
    result = chat_rooms.joins(:messages).where(messages: {user_id: user_id}).distinct
    return result.first
  end
end
