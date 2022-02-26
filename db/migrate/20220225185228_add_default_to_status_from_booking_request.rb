class AddDefaultToStatusFromBookingRequest < ActiveRecord::Migration[6.1]
  def change
    change_column :booking_requests, :status, :string, default: "Pending"
    change_column :booking_requests, :stay_status, :string, default: "On Request"
  end
end
