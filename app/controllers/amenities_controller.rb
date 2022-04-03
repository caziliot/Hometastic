class AmenitiesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  before_action :verify_flat
  def new
    @general_amenities = GeneralAmenity.all
    @flat = Flat.find(params[:flat_id])
    @amenity = Amenity.new
  end

  def create
    @result = amenity_params.delete("[]").split(",")
    @flat = Flat.find(params[:flat_id])
    @flat.edit_amenities(@result)
    respond_to do |format|
      format.html { redirect_to flat_path(@flat)}
      format.text {render partial: 'success', formats: [:html]}
    end

  end

  private

  def amenity_params
    params.require(:json)
  end
end
