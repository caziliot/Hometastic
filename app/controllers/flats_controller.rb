class FlatsController < ApplicationController
  before_action :authenticate_user!

  def index
    # Searching against available months and (location, name or address)
    if params[:query].present? && params[:search].present? && params[:search][:start_month].present? && params[:search][:end_month].present?
      @flats = Flat.joins(:available_months)
        .select("flats.*")
        .where("month_year >= :start_date AND month_year <= :end_date AND taken = :taken AND city ILIKE :location OR address ILIKE :location OR name ILIKE :location",
        {start_date: params[:search][:start_month], end_date: params[:search][:end_month], taken: false, location: "%#{params[:query]}%"})
        .group("flats.id")
    # Searching against available months
    elsif params[:search].present? && params[:search][:start_month].present? && params[:search][:end_month].present?
      @flats = Flat.joins(:available_months)
        .select("flats.*")
        .where("month_year >= :start_date AND month_year <= :end_date AND taken = :taken",
        {start_date: params[:search][:start_month], end_date: params[:search][:end_month], taken: false})
        .group("flats.id")
    # Search agains city, name, address
    elsif params[:query].present?
      sql_query = " \
        flats.city ILIKE :query \
        OR flats.address ILIKE :query \
        OR flats.name ILIKE :query
      "
      @flats = Flat.where(sql_query, query: "%#{params[:query]}%")
    # Show all flats (when no queries)
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

  def available_between?(date_s, date_e)
    months = available_months.select do |am|
      am.month_year.to_date >= date_s.to_date && am.month_year.to_date <= date_e.to_date && !am.taken
    end
    return months.any?
  end

  private

  def flat_params
    params.require(:flat).permit(:name, :address, :price, :description, :city, photos: [])
  end
end
