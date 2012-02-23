class AddTotalPriceToRides < ActiveRecord::Migration
  def self.up
    remove_column :rides, :price_per_seat
    add_column :rides, :total_price, :integer
  end

  def self.down
    add_column :rides, :price_per_seat, :integer
    remove_column :rides, :total_price
  end
end
