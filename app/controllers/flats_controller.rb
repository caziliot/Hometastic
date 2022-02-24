class FlatsController < ApplicationController
  before_action :authenticate_user!

  def index
    @flats = Flat.all
  end

  def show
    @flat = Flat.find(params[:id])
    @booking_requests = @flat.booking_requests
    @reviews = []
    @booking_requests.each do |b|
      @reviews << b.reviews
    end
    @user = current_user if user_signed_in?
  end

  def create
    @flat = Flat.new(flat_params)
    @flat.user = current_user
    if @flat.save
      redirect_to flat_path # not sure what path to redirect
    else
      render :new
    end
  end

  def new
    @user = current_user
    @flat = Flat.new
  end

  private

  def flat_params
    params.require(:flat).permit(:address, :price, :description, :city, :availabity, :photos)
  end
end
