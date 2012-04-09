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

ActiveRecord::Schema.define(:version => 20120409075347) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.string   "provider",    :null => false
    t.string   "uid",         :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "friend_list"
    t.text     "interests"
  end

  add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"

  create_table "feedbacks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "owner_id"
    t.integer  "ride_id"
    t.text     "feedback"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "feedbacks", ["owner_id"], :name => "index_feedbacks_on_owner_id"
  add_index "feedbacks", ["ride_id"], :name => "index_feedbacks_on_ride_id"
  add_index "feedbacks", ["user_id"], :name => "index_feedbacks_on_user_id"

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.integer  "zip"
    t.integer  "ride_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "locations", ["ride_id"], :name => "index_locations_on_ride_id"

  create_table "messages", :force => true do |t|
    t.integer  "user_id"
    t.integer  "owner_id"
    t.integer  "ride_id"
    t.text     "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "messages", ["owner_id"], :name => "index_messages_on_owner_id"
  add_index "messages", ["ride_id"], :name => "index_messages_on_ride_id"
  add_index "messages", ["user_id"], :name => "index_messages_on_user_id"

  create_table "request_loggers", :force => true do |t|
    t.text     "params"
    t.string   "user_agent"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "request_url"
    t.string   "referer"
    t.text     "cookie_string"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "ip_address"
  end

  create_table "ride_participants", :force => true do |t|
    t.integer  "ride_id"
    t.integer  "user_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.integer  "role",                   :default => 1
    t.integer  "number_of_seats"
    t.string   "phone"
    t.string   "mode_of_communications"
  end

  add_index "ride_participants", ["ride_id"], :name => "index_ride_participants_on_ride_id"
  add_index "ride_participants", ["user_id"], :name => "index_ride_participants_on_user_id"

  create_table "rides", :force => true do |t|
    t.integer  "available_seats"
    t.string   "notes"
    t.string   "ride_type"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.integer  "duration_in_minutes"
    t.date     "departure_date"
    t.time     "departure_time"
    t.integer  "to_location_id"
    t.integer  "from_location_id"
    t.integer  "flexibility_in_minutes"
    t.integer  "total_price"
    t.integer  "status",                 :default => 1
    t.datetime "departuredatetime"
  end

  add_index "rides", ["from_location_id"], :name => "index_rides_on_from_location_id"
  add_index "rides", ["to_location_id"], :name => "index_rides_on_to_location_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "about"
    t.string   "gender"
    t.date     "dob"
    t.integer  "phone"
    t.string   "city"
    t.string   "town"
    t.string   "work"
    t.string   "title"
    t.string   "school"
    t.datetime "deleted_at"
    t.string   "user_image"
    t.integer  "number_of_friends",            :default => 0
    t.string   "photo_url"
    t.text     "oauth_code"
    t.datetime "last_login"
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

end
