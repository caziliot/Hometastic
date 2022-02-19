class FlatsController < ApplicationController
  before_action :authenticate_user!

  def index
    @flats = current_user.flats
  end
end
