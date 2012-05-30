class AddInterestsInUser < ActiveRecord::Migration
  def up
    add_column :users, :interest, :text
  end

  def down
    remove_column :users, :interest
  end
end
