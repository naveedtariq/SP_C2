class AddLocationIdToRides < ActiveRecord::Migration
  def change
    add_column :rides, :location_id, :integer

  end
end
