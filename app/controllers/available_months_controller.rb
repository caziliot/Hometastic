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
      respond_to do |format|
        format.html { redirect_to flat_path(@flat)}
        format.text { render partial: 'flats/month_p', locals: { month: @available_month }, formats: [:html] }
      end
    else
      flash[:notice] = @available_month.errors.full_messages
      respond_to do |format|
        format.html { render "flats/show"}
        format.text { render partial: "components/available_form", locals: {flat: @flat, available_month: @available_month}, formats: [:html] }
      end

    end
  end

 private

  def months_params
    params.require(:available_month).permit(:month_year)
  end
end
