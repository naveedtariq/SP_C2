class AddNumberOfSeatsPhoneModeOfCommunicationsToRideParticipants < ActiveRecord::Migration
  def change
    add_column :ride_participants, :number_of_seats, :integer

    add_column :ride_participants, :phone, :string

    add_column :ride_participants, :mode_of_communications, :string

  end
end
