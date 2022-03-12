class AvailableMonthsController < ApplicationController
  def new
    @available_month = AvailableMonth.new
    @flat = Flat.find(params[:flat_id])
  end

  def create
    @available_month = AvailableMonth.new(months_params)
    @available_month.flat = @flat
    if @available_month.save
      redirect_to flat_path(@flat)
    else
      render 'flat/show'
    end
  end

 private

  def months_params
    params.require(:available_month).permit(:month_year, :free)
  end
end
