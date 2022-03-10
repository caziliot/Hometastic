class BookingRequest < ApplicationRecord
  # Stay Status: ['On Request', 'To be paid','Upcoming', 'in progress', 'Finished', 'Cancelled']
  # Status: ['Pending', 'Accepted', 'Declined']
  ACCEPTED = "Accepted"
  DECLINED = "Declined"
  PENDING = "Pending"

  ON_REQUEST = "On Request"
  TB_PAID = "To be paid"
  TBP_REQUESTER = "Awaiting requester payment"
  TBP_OWNER = "Awaiting owner payment"
  UPCOMING = "Upcoming"
  IN_PROGRESS = "In progress"
  FINISHED = "Finished"
  CANCELLED = "Cancelled"

  belongs_to :user
  belongs_to :flat
  has_many :reviews, dependent: :destroy
  validates :flat, presence: true
  validates :user, presence: true
  validates :month_request, presence: true
  validates_date :month_request, after: -> { Date.current }, message: "date must be after today"
  validate :flat_needs_to_be_available_on_the_month_requested
  validate :booking_already_exists, on: :create
  validate :self_booking
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
    errors.add(:flat, "flat is not available on the month requested") unless flat.available?(month_request)
  end

  def booking_already_exists
    errors.add(:user, "The user already sent a request like this one") if user.booked?(month_request, flat.id)
  end

  def self_booking
    errors.add(:user, "User can't book his own flat") if user.id == flat.user.id
  end

  def accept
    update(status: ACCEPTED, stay_status: TB_PAID)
    available = flat.available_months.find_by(month_year: month_request)
    available_r = user.flats.first.available_months.find_by(month_year: month_request)
    available&.take
    available_r&.take
  end

  def owner_pays
    if paid_by_requester
      update(paid_by_owner: true, stay_status: UPCOMING)
    else
      update(paid_by_owner: true, stay_status: TBP_REQUESTER)
    end
  end

  def requester_pays
    if paid_by_owner
      update(paid_by_requester: true, stay_status: UPCOMING)
    else
      update(paid_by_requester: true, stay_status: TBP_OWNER)
    end
  end
end
