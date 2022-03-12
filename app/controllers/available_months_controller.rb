class AvailableMonthsController < ApplicationController
  def new
    @available_month = AvailableMonth.new
    @flat = Flat.find(params[:flat_id])
  end

  def create
    @available_month = AvailableMonth.new(months_params)
    @flat = Flat.find(params[:flat_id])
    @available_month.flat = @flat
    # @available_month.save!
    if @available_month.save
      redirect_to flat_path(@flat)
    else
      render "flats/show"
    end
  end

 private

  def months_params
    params.require(:available_month).permit(:month_year, :free)
  end
end
