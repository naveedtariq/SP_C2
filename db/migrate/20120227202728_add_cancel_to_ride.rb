class AddCancelToRide < ActiveRecord::Migration
  def self.up
    add_column :rides, :status, :integer, :default => 1
  end
  def self.down
    remove_column :rides, :status
  end
end
