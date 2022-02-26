class BookingRequestsController < ApplicationController
  before_action :authenticate_user!

  # The confirm page is only going to be shown once the booking is accepted.
  def confirm
    # User (@user) creates an outgoing request to flat
    @user = current_user
    @flat = Flat.find(params[:flat_id])
    @booking = BookingRequest.new(booking_request_params)
    # console
    @booking.user = @user
    @booking.flat = @flat
    @booking.calculate_prices
  end

  # There should be a create, for when the Booking is sent and one update for when the
  def create
    @user = current_user
    @flat = Flat.find(params[:flat_id])
    @booking = BookingRequest.new(booking_request_params)
    @booking.user = @user
    @booking.flat = @flat
    @booking.calculate_prices
    if @booking.save
      redirect_to dashboard_path
    else
      render 'flats/show'
    end
  end

  # This is just to keep in mind: Accept
  def accept
    @booking = BookingRequest.find(params[:id])
    @user = current_user
    @user.accept(@booking)
    redirect_to "pages/dashboard"
    return
  end

  protected

  def booking_request_params
    params.require(:booking_request).permit(:month_request)
  end
end
