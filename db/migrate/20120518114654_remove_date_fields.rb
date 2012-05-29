class RemoveDateFields < ActiveRecord::Migration
  def self.up
    remove_column :rides, :new_departure_time
    remove_column :rides, :ampm_time
    remove_column :rides, :departure_time
    remove_column :rides, :departure_date
  end

  def self.down
    add_column :rides, :new_departure_time, :string
    add_column :rides, :ampm_time, :string
    add_column :rides, :departure_time, :time
    add_column :rides, :departure_date, :date
  end
end
