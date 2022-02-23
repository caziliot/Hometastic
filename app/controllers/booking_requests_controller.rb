class BookingRequestsController < ApplicationController
  before_action :authenticate_user!

  def confirm
    # User (@user) creates an outgoing request to flat
    @user = current_user
    @flat = Flat.find(params[:flat_id])
    @booking = BookingRequest.new(booking_request_params)
    # console
    @booking.user = @user
    @booking.camper = @camper
    @booking.calculate_cost
  end


end
