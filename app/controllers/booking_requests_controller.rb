class BookingRequestsController < ApplicationController
  before_action :authenticate_user!

  # The confirm page is only going to be shown once the booking is accepted.
  def pay
    @booking = BookingRequest.find(params[:id])
    if current_user.id == @booking.user.id
      @booking.requester_pays
    elsif current_user.id == @booking.flat.user.id
      @booking.owner_pays
    else
      redirect_to dashboard_path
    end
  end

  def confirm
    @booking = BookingRequest.find(params[:id])
    @requester = @booking.user
    @owner = @booking.flat.user
  end

  def show
    @booking = BookingRequest.find(params[:id])
    if current_user.id == @booking.user_id
      @flat = Flat.find(@booking.flat_id)
    else
      @flat = Flat.find_by(user_id: @booking.user_id)
    end
    @marker = { lat: @flat.latitude, lng: @flat.longitude, image_url: helpers.asset_url('logo.png') }
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
    if @booking.flat.available?(@booking.month_request) && @user.flats.first.available?(@booking.month_request)
      @user.accept(@booking)
    else
      flash[:notice] = "Both flats need to be available on those dates."
    end
    redirect_to dashboard_path
    return
  end

  def decline
    @booking = BookingRequest.find(params[:id])
    @user = current_user
    if @user.decline(@booking)
      redirect_to dashboard_path
      flash[:notice] = "Booking declined."
    else
      flash[:notice] = "Sorry, but something went wrong."
    end
  end

  protected

  def booking_request_params
    params.require(:booking_request).permit(:month_request)
  end
end
