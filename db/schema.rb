# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_02_25_185228) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "available_months", force: :cascade do |t|
    t.string "month_year"
    t.bigint "flat_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "taken", default: false
    t.index ["flat_id"], name: "index_available_months_on_flat_id"
  end

  create_table "booking_requests", force: :cascade do |t|
    t.string "status", default: "Pending"
    t.string "month_request"
    t.string "direction"
    t.string "stay_status", default: "On Request"
    t.bigint "user_id", null: false
    t.bigint "flat_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "price_requester", precision: 10, scale: 2
    t.decimal "price_owner", precision: 10, scale: 2
    t.decimal "service_fee", precision: 10, scale: 2
    t.index ["flat_id"], name: "index_booking_requests_on_flat_id"
    t.index ["user_id"], name: "index_booking_requests_on_user_id"
  end

  create_table "chat_rooms", force: :cascade do |t|
    t.bigint "flat_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["flat_id"], name: "index_chat_rooms_on_flat_id"
  end

  create_table "flats", force: :cascade do |t|
    t.string "address"
    t.integer "price"
    t.text "description"
    t.string "city"
    t.string "photos", default: [], array: true
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_flats_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "chat_room_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chat_room_id"], name: "index_messages_on_chat_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "content"
    t.integer "rating"
    t.bigint "booking_request_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["booking_request_id"], name: "index_reviews_on_booking_request_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "available_months", "flats"
  add_foreign_key "booking_requests", "flats"
  add_foreign_key "booking_requests", "users"
  add_foreign_key "chat_rooms", "flats"
  add_foreign_key "flats", "users"
  add_foreign_key "messages", "chat_rooms"
  add_foreign_key "messages", "users"
  add_foreign_key "reviews", "booking_requests"
end
