class AddModeOfCommunicationsToUsers < ActiveRecord::Migration

 def self.up
  add_column :users, :mode_of_communications, :string
 end

 def self.down
  remove_column :users, :mode_of_communications
 end

end
