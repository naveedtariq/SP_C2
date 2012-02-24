class RemoveUserIdFromRides < ActiveRecord::Migration
  def up
    remove_column :rides, :user_id
    remove_column :ride_participants, :role
    add_column :ride_participants, :role, :integer, :default => ROLES_FOR_RIDES[:owner]
  end

  def down
    add_column :rides, :user_id, :integer
    remove_column :ride_participants, :role
    add_column :ride_participants, :role, :string 
  end
end
