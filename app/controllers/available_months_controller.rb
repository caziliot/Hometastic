class AvailableMonthsController < ApplicationController
  def create
    @user = current_user
    @flat.user = current_user
  end
end
