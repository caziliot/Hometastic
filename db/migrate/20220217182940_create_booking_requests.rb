class CreateBookingRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :booking_requests do |t|
      t.string :status
      t.string :month_request
      t.integer :price
      t.string :direction
      t.string :stay_status
      t.references :user, null: false, foreign_key: true
      t.references :flat, null: false, foreign_key: true

      t.timestamps
    end
  end
end
