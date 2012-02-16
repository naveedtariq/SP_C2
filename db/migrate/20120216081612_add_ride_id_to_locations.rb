class AddRideIdToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :ride_id, :integer

  end
end
