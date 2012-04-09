class AddDatetimeToRides < ActiveRecord::Migration
  def change
    add_column :rides, :departuredatetime, :datetime

  end
end
