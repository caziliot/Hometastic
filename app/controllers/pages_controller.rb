class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_flat, only: [:dashboard ]
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @user = current_user if user_signed_in?
  end
end
