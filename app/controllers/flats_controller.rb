class FlatsController < ApplicationController
  before_action :authenticate_user!

  def index
    #location
    # if params[:query].present?
    #  @flats = Flat.search_by_name_date_price_direction_city(params[:query])
    # else
    #  @flats = Flat.all
    # end


    if params[:start_date].present? && params[:end_date].present?
      sql_query = " \
        flats.city ILIKE :query \
        OR flats.address ILIKE :query \
        OR flats.name ILIKE :query
      "
    elsif params[:query].present?
      sql_query = " \
        flats.city ILIKE :query \
        OR flats.address ILIKE :query \
        OR flats.name ILIKE :query
      "
      @flats = Flat.where(sql_query, query: "%#{params[:query]}%")


    # elsif
    #   @flats = Flat.all
    # end
    else
    @flats = Flat.all
    end
  end

  def show

    @flat = Flat.find(params[:id])
    @reviews = @flat.reviews
    @amenities = @flat.amenities
    @user = current_user if user_signed_in?
    @booking = BookingRequest.new
  end

  def create
    @flat = Flat.new(flat_params)
    @flat.user = current_user
    if @flat.save
      redirect_to @flat
    else
      render :new
    end
  end

  def new
    if current_user.flats.any?
      redirect_to flat_path(current_user.flats.first)
    else
      @flat = Flat.new
    end
  end

  def edit
    @flat = Flat.find(params[:id])
    redirect_to flat_path(@flat) unless @flat.user = current_user
  end

  def update
    @flat = Flat.find(params[:id])
    if @flat.update(flat_params)
      redirect_to flat_path(@flat)
    else
      flash[:alert] = "Error while updating, try again later"
      redirect_to flat_path(@flat)
    end
  end

  def available_months

  end

  private

  def flat_params
    params.require(:flat).permit(:name, :address, :price, :description, :city, photos: [])
  end
end
