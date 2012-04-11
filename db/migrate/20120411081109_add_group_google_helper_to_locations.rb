class AddGroupGoogleHelperToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :group, :string
    add_column :locations, :google_helper, :string
  end
end
