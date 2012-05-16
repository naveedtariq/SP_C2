class AddNewDepartureTimeAmpmTimeToRides < ActiveRecord::Migration

  def self.up
    add_column :rides, :new_departure_time, :string
    add_column :rides, :ampm_time, :string
  end

  def self.down
    add_column :rides, :new_departure_time
    add_column :rides, :ampm_time
  end

end
