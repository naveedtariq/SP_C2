#require "migration_helpers"
class AddForeignKeys < ActiveRecord::Migration
#  extend MigrationHelpers
  def self.up
#    add_foreign_key(:ride, :id, :ride_participants)
#    add_foreign_key(:user, :id, :ride_participants)
#    add_foreign_key(:location, :to_location_id, :rides)
#    add_foreign_key(:location, :from_location_id, :rides)
   end
#
 def self.down
#  remove_foreign_key(:ride, :id, :ride_participants)
#  remove_foreign_key(:user, :id, :ride_participants)
#  remove_foreign_key(:location, :to_location_id, :rides)
#remove_foreign_key(:location, :from_location_id, :rides)
  end
end
