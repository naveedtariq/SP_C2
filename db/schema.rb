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

ActiveRecord::Schema.define(:version => 20120227202728) do

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
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
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
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

end
