class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.string :type
      t.integer :min_seats
      t.integer :max_seats
      t.integer :price_per_seat
      t.string :description
      t.time :start_time
      t.time :arrival_time
      t.string :flexibility

      t.timestamps
    end
  end
end
