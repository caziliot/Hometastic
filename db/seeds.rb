# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'open-uri'
puts "cleaning the db"
Message.destroy_all
ChatRoom.destroy_all
Review.destroy_all
BookingRequest.destroy_all
Flat.destroy_all
User.destroy_all
puts "start seeding"
5.times do |i|
  user = User.create!(
    email: Faker::Internet.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone_number: Faker::PhoneNumber.cell_phone,
    password: "123456"
  )
  puts "User ##{i + 1}, #{user.first_name}"

  flat = Flat.new(
    name: Faker::Company.name,
    address: Faker::Address.street_name,
    price: Faker::Commerce.price,
    description: Faker::Restaurant.description,
    city: Faker::Address.city,
    user_id: user.id
  )
  file = URI.open('https://picsum.photos/200/300')
  flat.photos.attach(io: file, filename: 'nes.png', content_type: 'image/png')
  flat.save!
  puts "flat ##{i + 1}, #{flat.address}"

  ava_m = AvailableMonth.create!(
    month_year: "01-0#{rand(4..9)}-2022",
    flat_id: flat.id
  )
  puts "Available Month ##{ava_m.id}, #{ava_m.month_year}"
end

5.times do |i|
  booking_request = BookingRequest.create!(
    direction: Faker::Address.street_address,
    user_id: rand(User.first.id..User.last.id),
    flat_id: rand(Flat.first.id..Flat.last.id),
    month_request: "01-04-2022"
  )
  booking_request.month_request = booking_request.flat.available_months.first.month_year
  booking_request.calculate_prices
  booking_request.save
  puts "booking request ##{i + 1}, #{booking_request.stay_status}, #{booking_request.direction}"

  review = Review.create!(
    content: ["good", "bad", "terrible", "amazing"].sample,
    rating: rand(1..5),
    booking_request_id: booking_request.id
  )
  puts "reviews ##{i + 1}, #{review.content} #{review.rating}"

  chatroom = ChatRoom.create!(
    flat_id: rand(Flat.first.id..Flat.last.id)
  )
  puts "chat ##{i + 1}, chating with user ##{chatroom.flat_id}"

  message = Message.create!(
    content: ["Message", "something", "else"].sample,
    user_id: rand(User.first.id..User.last.id),
    chat_room_id: chatroom.id
  )
  puts "message: ##{message.content}, from: user ##{message.user_id}, on: chat ##{message.chat_room_id}"
end
puts "seeding finished successfully"
