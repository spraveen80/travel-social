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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120405120815) do

  create_table "airlines", :force => true do |t|
    t.string   "name"
    t.string   "alias"
    t.string   "iata_code"
    t.string   "icao_code"
    t.string   "callsign"
    t.boolean  "active"
    t.integer  "country_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "airlines", ["iata_code"], :name => "index_airlines_on_iata_code"
  add_index "airlines", ["icao_code"], :name => "index_airlines_on_icao_code"
  add_index "airlines", ["name"], :name => "index_airlines_on_name"

  create_table "airports", :force => true do |t|
    t.string   "icao_code"
    t.string   "name"
    t.integer  "city_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "iata_code"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "altitude"
    t.float    "timezone"
    t.string   "dst"
  end

  add_index "airports", ["iata_code"], :name => "index_airports_on_iata_code"
  add_index "airports", ["icao_code"], :name => "index_airports_on_icao_code"
  add_index "airports", ["name"], :name => "index_airports_on_name"

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "flights", :force => true do |t|
    t.integer  "itinerary_id"
    t.integer  "from_airport_id"
    t.date     "dep_date"
    t.time     "dep_time"
    t.integer  "to_airport_id"
    t.date     "arr_date"
    t.time     "arr_time"
    t.integer  "airline_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "itineraries", :force => true do |t|
    t.integer  "user_id"
    t.string   "passenger_name"
    t.boolean  "need_help"
    t.boolean  "willing_to_help"
    t.string   "type"
    t.integer  "start_airport_id"
    t.integer  "dest_airport_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "remember_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
