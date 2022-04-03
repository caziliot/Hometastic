class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_flat
  def new
    @booking = BookingRequest.find(params[:booking_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @booking = BookingRequest.find(params[:booking_request_id])
    @flat = @booking.flat
    @review.booking_request = @booking
    if @review.save
      redirect_to flat_path(@flat)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
