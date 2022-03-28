class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :flats
  has_many :booking_requests # Outgoing booking requests, booking as a customer
  has_many :messages
  has_many :incoming_chatrooms, through: :flats, source: :chat_rooms # chats received as owners
  has_many :chat_rooms # Outgoing Chats sent to owners
  has_many :booking_as_owner, through: :flats, source: :booking_requests # Bookings incoming, to my flat

  has_one_attached :photo

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true
  validates :email, 'valid_email_2/email': { blacklist: true, message: "is not a valid email" }

  def total_swaps
    booking_requests.where(stay_status: BookingRequest::FINISHED).count + booking_as_owner.where(stay_status: BookingRequest::FINISHED).count
  end

  def swaps_per_current_year
    current_year = Date.current.year
    outgoing_bookings_r = booking_requests.where(stay_status: BookingRequest::FINISHED)
    ob = outgoing_bookings_r.select do |book|
      book.month_request.to_date.year == current_year
    end
    incoming_bookings_r = booking_as_owner.where(stay_status: BookingRequest::FINISHED)
    ib = incoming_bookings_r.select do |book|
      book.month_request.to_date.year == current_year
    end
    return ob.size + ib.size

  end

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
    status = booking.update(status: BookingRequest::DECLINED, stay_status: BookingRequest::CANCELLED)
    return status
  end

  def all_chats
    chat_rooms + incoming_chatrooms
  end


end
