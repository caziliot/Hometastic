class FlatsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:query]
      @flats = Flat.search_by_name_date_price_direction_city(params[:query])
    else
      @flats = Flat.all
    end
  end

  def show
    @flat = Flat.find(params[:id])
    @reviews = @flat.reviews
    @user = current_user if user_signed_in?
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
    @flat = Flat.new
  end

  private

  def flat_params
    params.require(:flat).permit(:address, :price, :description, :city, :photos)
  end
end
