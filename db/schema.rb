# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150126223646) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "addresses", force: true do |t|
    t.string  "street"
    t.string  "city"
    t.string  "state_code"
    t.string  "country_code"
    t.string  "country_name"
    t.string  "postal_code"
    t.decimal "longitude",    precision: 9, scale: 6
    t.decimal "latitude",     precision: 9, scale: 6
  end

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "car_rentals", force: true do |t|
    t.string   "company_name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "confirmation_code"
    t.integer  "user_id"
    t.string   "car_type"
    t.integer  "pickup_address_id"
    t.integer  "dropoff_address_id"
    t.string   "pickup_phone"
    t.string   "dropoff_phone"
    t.text     "notes"
  end

  add_index "car_rentals", ["dropoff_address_id"], name: "index_car_rentals_on_dropoff_address_id", using: :btree
  add_index "car_rentals", ["pickup_address_id"], name: "index_car_rentals_on_pickup_address_id", using: :btree
  add_index "car_rentals", ["user_id"], name: "index_car_rentals_on_user_id", using: :btree

  create_table "email_imports", force: true do |t|
    t.integer  "user_id"
    t.string   "status"
    t.text     "xml"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flight_plans", force: true do |t|
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "departure_airport_code"
    t.string   "arrival_airport_code"
    t.integer  "itinerary_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "confirmation_code"
    t.integer  "user_id"
    t.string   "airline_code"
    t.string   "flight_number"
    t.string   "airline_name"
    t.string   "duration"
    t.string   "distance"
    t.string   "class_type"
    t.string   "departure_airport_name"
    t.float    "departure_latitude"
    t.float    "departure_longitude"
    t.string   "departure_terminal"
    t.string   "departure_gate"
    t.string   "arrival_airport_name"
    t.float    "arrival_latitude"
    t.float    "arrival_longitude"
    t.string   "arrival_terminal"
    t.string   "arrival_gate"
  end

  create_table "hotel_bookings", force: true do |t|
    t.string   "hotel_name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "confirmation_code"
    t.integer  "user_id"
    t.string   "room"
    t.string   "hotel_phone"
    t.integer  "address_id"
  end

  add_index "hotel_bookings", ["address_id"], name: "index_hotel_bookings_on_address_id", using: :btree
  add_index "hotel_bookings", ["user_id"], name: "index_hotel_bookings_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "authentication_token"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
