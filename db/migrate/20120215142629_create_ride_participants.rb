class CreateRideParticipants < ActiveRecord::Migration
  def change
    create_table :ride_participants do |t|
      t.integer :ride_id
      t.integer :user_id
      t.string :role

      t.timestamps
    end
  end
end
