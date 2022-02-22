# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
puts "cleaning the db"
Message.destroy_all
Chat.destroy_all
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

  flat = Flat.create!(
    address: Faker::Address.street_name,
    price: Faker::Commerce.price,
    description: Faker::Restaurant.description,
    city: Faker::Address.city,
    availability: ["available", "taken"].sample,
    user_id: user.id
  )
  puts "flat ##{i + 1}, #{flat.address}"
end

5.times do |i|
  booking_request = BookingRequest.create!(
    status: ["available", "rented"].sample,
    month_request: Date::MONTHNAMES.sample,
    price: Faker::Commerce.price,
    direction: Faker::Address.street_address,
    stay_status: ["stay in the moment", "in the future", "past stay"].sample,
    user_id: rand(User.first.id..User.last.id),
    flat_id: rand(Flat.first.id..Flat.last.id)
  )
  puts "booking request ##{i + 1}, #{booking_request.stay_status}, #{booking_request.direction}"

  review = Review.create!(
    content: ["good", "bad", "terrible", "amazing"].sample,
    rating: rand(5..10),
    booking_request_id: booking_request.id
  )
  puts "reviews ##{i + 1}, #{review.content} #{review.rating}"

  chat = Chat.create!(
    flat_id: rand(Flat.first.id..Flat.last.id)
  )
  puts "chat ##{i + 1}, chating with user ##{chat.flat_id}"

  message = Message.create!(
    content: ["Message", "something", "else"].sample,
    user_id: rand(User.first.id..User.last.id),
    chat_id: chat.id
  )
  puts "message: ##{message.content}, from: user ##{message.user_id}, on: chat ##{message.chat_id}"
end
puts "seeding finished successfully"
