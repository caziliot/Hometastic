class BookingRequest < ApplicationRecord
  belongs_to :user
  belongs_to :flat
  has_many :reviews, dependent: :destroy
  validates :flat, presence: true
  validates :user, presence: true
  validates :month_request, presence: true

  # calculate the Service Fee as 10% of the most expensive flat, that both should pay.
  def calculate_service_fee
    user_flat = user.flats.first
    self.service_fee = flat.price > user_flat.price ? flat.price * 0.10 : user_flat.price * 0.10
  end

  def calculate_prices
    calculate_service_fee
    # Requester Flat (The one that sends the request)
    rq_flat = user.flats.first
    # The absolute difference of flat prices.
    dif = (flat.price - rq_flat.price).abs
    self.price_owner = flat.price > rq_flat.price ? service_fee : dif + service_fee
    self.price_requester = price_owner > service_fee ? service_fee : dif + service_fee
  end

  def flat_available?
    if flat.available_months.any?
      date_r = month_request.to_date
      m_a = flat.available_months.select { |month| month.month_year.to_date == date_r }
      return m_a.any?
    end
    return false
  end
end
