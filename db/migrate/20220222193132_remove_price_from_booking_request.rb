class RemovePriceFromBookingRequest < ActiveRecord::Migration[6.1]
  def change
    remove_column :booking_requests, :price
  end
end
