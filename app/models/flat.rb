class Flat < ApplicationRecord
  belongs_to :user
  has_many :chats
  has_many :booking_requests
  has_many :messages, through: :chats
  has_many :available_months, dependent: :destroy
  has_many :reviews, through: :booking_requests

  validates :address, presence: true
  validates :price, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :city, presence: true
  validates :photos, presence: true

  def available?(date_s)
    if flat.available_months.any?
      date_r = date_s.to_date
      m_a = flat.available_months.select { |month| month.month_year.to_date == date_r && !month.taken }
      return m_a.any?
    end
    return false
  end
  # validates :photos, presence: true *temporarily commented for testing purposes
end
