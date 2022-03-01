class ChangeColumnsFromBookingRequests < ActiveRecord::Migration[6.1]
  def change
    change_column :booking_requests, :price_requester, :decimal, precision: 10, scale: 2
    change_column :booking_requests, :price_owner, :decimal, precision: 10, scale: 2
    change_column :booking_requests, :service_fee, :decimal, precision: 10, scale: 2
  end
end
