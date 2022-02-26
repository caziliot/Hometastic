class AddPriceRequesterToBookingRequest < ActiveRecord::Migration[6.1]
  def change
    add_column :booking_requests, :price_requester, :decimal, precision: 3, scale: 2
  end
end
