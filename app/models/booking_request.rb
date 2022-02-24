class BookingRequest < ApplicationRecord
  belongs_to :user
  belongs_to :flat
  has_many :reviews, dependent: :destroy
  validates :flat, presence: true
  validates :user, presence: true
  validates :month_request, presence: true
  validate :flat_needs_to_be_available_on_the_month_requested

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

  def flat_needs_to_be_available_on_the_month_requested
    errors.add(:flat, "flat is not available on the month requested") unless flat.available(month_request)
  end
end
