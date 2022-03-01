class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :flats
  has_many :booking_requests # Outgoing booking requests, booking as a customer
  has_many :messages
  has_many :chatrooms, through: :flats
  has_many :booking_as_owner, through: :flats, source: :booking_requests # Bookings incoming, to my flat


  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true

  def booked?(month_request, flat_id)
    return !booking_requests.find_by(month_request: month_request, flat_id: flat_id).nil?
  end

  def accept(booking)
    if booking.status == BookingRequest::PENDING
      booking.accept
      booking_as_owner.where(month_request: booking.month_request).each do |b|
        b.update(status: BookingRequest::DECLINED) unless b.id == booking.id
      end
      booking_requests.where(month_request: booking.month_request).each do |b|
        b.update(status: BookingRequest::CANCELLED) unless b.id == booking.id
      end
    else
      flash[:notice] = "This booking is not pending anymore"
    end
  end

  def decline(booking)
    booking.update(status: BookingRequest::DECLINED)
  end
end
