require "#{Rails.root}/lib/migration_helpers"
class AddForeignKeys < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    add_foreign_key(:ride_participants, :rides, :ride_id, :id)
    add_foreign_key(:ride_participants, :users, :user_id, :id)
    add_foreign_key(:rides, :locations, :to_location_id, :id)
    add_foreign_key(:rides, :locations, :from_location_id, :id)
   end
#
  def self.down
    remove_foreign_key(:ride_participants, :ride_id)
    remove_foreign_key(:ride_participants, :user_id)
    remove_foreign_key(:rides, :from_location_id)
    remove_foreign_key(:rides, :to_location_id)
  end
end
