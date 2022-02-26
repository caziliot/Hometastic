class AddPaymentColumnsToBookingRequests < ActiveRecord::Migration[6.1]
  def change
    add_column :booking_requests, :paid_by_owner, :boolean, default: false
    add_column :booking_requests, :paid_by_requester, :boolean, default: false
  end
end
