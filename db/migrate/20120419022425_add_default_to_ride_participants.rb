class AddDefaultToRideParticipants < ActiveRecord::Migration
  def self.up
    change_column :ride_participants, :number_of_seats, :integer, :default => 1
    RideParticipant.where("number_of_seats is NULL").update_all(number_of_seats: 1)
  end
  def self.down
  end
end
