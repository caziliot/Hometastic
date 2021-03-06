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
GeneralAmenity.destroy_all
puts "start seeding"
GeneralAmenity.create!(title: "Wifi", icon_class: "ant-design:wifi-outlined")
GeneralAmenity.create!(title: "Barbecue", icon_class: "ic:baseline-outdoor-grill")
GeneralAmenity.create!(title: "Shared furnished terrace", icon_class: "mdi:flower-tulip")
GeneralAmenity.create!(title: "Hairdrier", icon_class: "jam:hairdryer")
GeneralAmenity.create!(title: "Work desk", icon_class: "mdi:desk")
GeneralAmenity.create!(title: "heater", icon_class: "mdi:patio-heater")
GeneralAmenity.create!(title: "TV", icon_class: "entypo:tv")
GeneralAmenity.create!(title: "Double size Bed", icon_class: "ic:baseline-bed")
GeneralAmenity.create!(title: "Pet-friendly space", icon_class: "dashicons:pets")
GeneralAmenity.create!(title: "Jacuzzi", icon_class: "ic:baseline-hot-tub")
GeneralAmenity.create!(title: "Air continioning", icon_class: "ic:twotone-ac-unit")
GeneralAmenity.create!(title: "Smoke Detector", icon_class: "mdi:smoke-detector-variant-alert")


7.times do |i|
  user = User.new(
    email: "email-#{i}@email.com",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone_number: Faker::PhoneNumber.cell_phone,
    password: "123456"
  )
  file1 = URI.open('https://picsum.photos/200/300')
  user.photo.attach(io: file1, filename: 'user.png', content_type: 'image/png')
  user.save!
  puts "User ##{i + 1}, #{user.first_name}"

  flat = Flat.new(
    name: ["Epic Barceloneta Beach and Marina Apartment Blanco", "Light Studio Flat - Brand New - Chelsea", "Studio 'Spicy Wasabi' 31 qm", "Petit Studio Paris Centre", "Monolocale : cucina, bagno, terrazza comune"].sample,
    address: Faker::Address.street_name,
    price: rand(400..900),
    description: Faker::Restaurant.description,
    city: Faker::Address.city,
    user_id: user.id,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude
  )
  1.times do
    file = URI.open('https://source.unsplash.com/random/?apartment')
    flat.photos.attach(io: file, filename: 'nes.png', content_type: 'image/png')
  end
  flat.save!
  puts "flat ##{i + 1}, #{flat.address}"
  3.times do |j|
    ava_m = AvailableMonth.create!(
      month_year: "01-0#{5+j}-2022",
      flat_id: flat.id
    )

    puts "Available Month ##{ava_m.id} for Flat ##{flat.id}, #{ava_m.month_year}"
  end
end
 j= 1
year = 2020
24.times do |i|
  user_id = rand(User.first.id..User.last.id)
  flat = Flat.find_by(user_id: user_id)
  flat_id = flat.id
  while(flat.user.id == user_id) do
    flat_id = rand(Flat.first.id..Flat.last.id)
    flat = Flat.find(flat_id)
  end
  booking_request = BookingRequest.create!(
    direction: Faker::Address.street_address,
    user_id: user_id,
    flat_id: flat_id,
    month_request: "01-05-2022"
  )

  booking_request.calculate_prices
  booking_request.save
  booking_request.month_request = "01-#{j}-#{year}"
  av = AvailableMonth.create!(month_year: "01-11-2022", flat_id: flat_id)
  av.month_year = "01-#{j}-#{year}"
  av.take
  av.save!
  booking_request.stay_status = BookingRequest::FINISHED
  booking_request.status = BookingRequest::ACCEPTED
  booking_request.save!
  puts "booking request ##{i + 1}, #{booking_request.stay_status}, #{booking_request.direction}"

  review = Review.create!(
    content: ["Location of the flat is superb. Jacopo was extremely welcoming and helpful. Everything was clean and tidy and we thoroughly enjoyed our stay", "Great location and the apartment was very clean and had good facilities. The roof terrace is fantastic.", "The place is very well located near to Pantheon and Piazza Navona.. supermarkets and restaurants are nearby.. bus stops are nearby to go to Vatican City, Roma Termini etc.. House is sparkling clean and the bldg had an amazing terrace where couples can have romantic dinners", "Very accommodating! Clean place!", "Amazing Price for charming place in the heart of rome. Jacopo is a good host and reply???s very fast"].sample,
    rating: rand(1..5),
    booking_request_id: booking_request.id
  )
  puts "reviews ##{i + 1}, #{review.content} #{review.rating}"

  j+= 1
  if j == 12
    j = 1
    year += 1
  end


end

4.times do |i|
  user_id = rand(User.first.id..User.last.id)
  flat = Flat.find_by(user_id: user_id)
  flat_id = flat.id
  while(flat.user.id == user_id || ChatRoom.find_by(flat_id: flat_id, user_id: user_id)) do
    flat_id = rand(Flat.first.id..Flat.last.id)
    flat = Flat.find(flat_id)
  end
  chatroom = ChatRoom.create!(
    flat_id: flat_id,
    user_id: user_id
  )
  puts "chat ##{i + 1}, chating with user ##{chatroom.flat_id}"

  message = Message.create!(
    content: ["Hello! I have a question on your flat", "Hi, is it available next month?", "Do you mind having dogs", "Good Evening"].sample,
    user_id: user_id,
    chat_room_id: chatroom&.id
  )
  puts "message: ##{message.content}, from: user ##{message.user_id}, on: chat ##{message.chat_room_id}"
end
puts "seeding finished successfully"
