# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
puts 'Creating 5 booking_requests...'
5.times do |i|
  users = User.create!(
    email: Faker::Internet.email,
    first_name: Faker::Name.name,
    last_name: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.cell_phone
  )
  puts "User ##{i}, #{users.first_name}"

  # booking = BookingRequest.create!(
  #   status: "Pending",
  #   month_request: ,
  #   price: ,
  #   direction: ,
  #   stay_status: ,
  #   user_id: ,
  #   flat_id:
  # )
end
puts 'Finished!'
