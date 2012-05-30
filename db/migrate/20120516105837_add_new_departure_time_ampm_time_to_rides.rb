class AddNewDepartureTimeAmpmTimeToRides < ActiveRecord::Migration

  def self.up
    add_column :rides, :new_departure_time, :string
    add_column :rides, :ampm_time, :string
  end

  def self.down
    remove_column :rides, :new_departure_time
    remove_column :rides, :ampm_time
  end

end
