class AmenitiesController < ApplicationController
  def new
    @general_amenities = GeneralAmenity.all
    @flat = Flat.find(params[:flat_id])
    @amenity = Amenity.new
  end

  def create
    @amenity = Amenity.new(amenity_params)
    @flat = Flat.find(params[:flat_id])
    @amenity.flat = @flat
    if @amenity.save
      redirect_to flat_path(@flat)
    else
      render :new
    end
  end

  private

  def amenity_params
    params.require(:amenity).permit(:title, :icon_class)
  end
end
