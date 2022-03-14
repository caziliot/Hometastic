class AmenitiesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def new
    @general_amenities = GeneralAmenity.all
    @flat = Flat.find(params[:flat_id])
    @amenity = Amenity.new
  end

  def create
    @result = amenity_params.delete("[]").split(",")
    @flat = Flat.find(params[:flat_id])
    amenities = []
    @result.each do |id|
      g = GeneralAmenity.find(id)
      a= Amenity.new(title: g.title, icon_class: g.icon_class, flat_id: @flat.id)
      amenities << a
    end
    Amenity.transaction do
      amenities.each do |a|
        a.save!
      end
    end

    respond_to do |format|
      format.html { @vars
        raise
      }
      format.text {
        render partial: 'success', formats: [:html]
      }
    end

  end

  private

  def amenity_params
    params.require(:json)
  end
end
