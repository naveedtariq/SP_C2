class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.integer :available_seats
      t.integer :price_per_seat
      t.string :notes
      t.integer :user_id
      t.string :ride_type
      t.string :to_city
      t.string :from_city
      t.date :departure_date
      t.time :departure_time
      t.integer :duration
      t.integer :flexibility
      t.timestamps
    end
  end
end
