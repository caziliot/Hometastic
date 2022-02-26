class FlatsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:query].present?
      sql_query = " \
        flats.city ILIKE :query \
        OR flats.address ILIKE :query \
      "
      @flats = Flat.where(sql_query, query: "%#{params[:query]}%")
    else
      @flats = Flat.all
    end
    @cities = Flat.all.select{|flat| flat.city}
    @months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    @years = ["2022", "2023", "2024", "2025", "2026"]
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
