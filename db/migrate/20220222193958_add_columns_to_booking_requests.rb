class AddColumnsToBookingRequests < ActiveRecord::Migration[6.1]
  def change
    add_column :booking_requests, :price_owner, :decimal, precision: 3, scale: 2
    add_column :booking_requests, :service_fee, :decimal, precision: 3, scale: 2
  end
end
