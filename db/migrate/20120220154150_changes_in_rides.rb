class ChangesInRides < ActiveRecord::Migration
  def self.up
    remove_column :rides, :arrival_datetime
    add_column :rides, :duration_in_minutes, :integer
    remove_column :rides, :departure_datetime
    add_column :rides, :departure_date, :date
    add_column :rides, :departure_time, :time
    remove_column :rides, :from_city
    remove_column :rides, :to_city
    add_column :rides, :to_location_id, :integer
    add_column :rides, :from_location_id, :integer
    
    
    remove_column :rides, :flexibility
    add_column :rides, :flexibility_in_minutes, :integer

  end
  def self.down
    add_column :rides, :arrival_datetime, :datetime
    remove_column :rides, :duration_in_minutes
    add_column :rides, :departure_datetime, :datetime
    remove_column :rides, :departure_date
    remove_column :rides, :departure_time
    add_column :rides, :from_city, :integer
    add_column :rides, :to_city, :integer
    remove_column :rides, :to_location_id
    remove_column :rides, :from_location_id
    add_column :rides, :flexibility, :integer
    add_column :rides, :flexibility_in_minutes, :integer
  end
end
