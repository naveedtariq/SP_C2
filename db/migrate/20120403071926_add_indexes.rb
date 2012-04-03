class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"
    add_index "feedbacks", ["user_id"], :name => "index_feedbacks_on_user_id"
    add_index "feedbacks", ["owner_id"], :name => "index_feedbacks_on_owner_id"
    add_index "feedbacks", ["ride_id"], :name => "index_feedbacks_on_ride_id"
    add_index "locations", ["ride_id"], :name => "index_locations_on_ride_id"
    add_index "messages", ["user_id"], :name => "index_messages_on_user_id"
    add_index "messages", ["owner_id"], :name => "index_messages_on_owner_id"
    add_index "messages", ["ride_id"], :name => "index_messages_on_ride_id"
    add_index "ride_participants", ["user_id"], :name => "index_ride_participants_on_user_id"
    add_index "ride_participants", ["ride_id"], :name => "index_ride_participants_on_ride_id"
    add_index "rides", ["to_location_id"], :name => "index_rides_on_to_location_id"
    add_index "rides", ["from_location_id"], :name => "index_rides_on_from_location_id"
  end

  def self.down
    remove_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"
    remove_index "feedbacks", ["user_id"], :name => "index_feedbacks_on_user_id"
    remove_index "feedbacks", ["owner_id"], :name => "index_feedbacks_on_owner_id"
    remove_index "feedbacks", ["ride_id"], :name => "index_feedbacks_on_ride_id"
    remove_index "locations", ["ride_id"], :name => "index_locations_on_ride_id"
    remove_index "messages", ["user_id"], :name => "index_messages_on_user_id"
    remove_index "messages", ["owner_id"], :name => "index_messages_on_owner_id"
    remove_index "messages", ["ride_id"], :name => "index_messages_on_ride_id"
    remove_index "ride_participants", ["user_id"], :name => "index_ride_participants_on_user_id"
    remove_index "ride_participants", ["ride_id"], :name => "index_ride_participants_on_ride_id"
    remove_index "rides", ["to_location_id"], :name => "index_rides_on_to_location_id"
    remove_index "rides", ["from_location_id"], :name => "index_rides_on_from_location_id"
  end
end
