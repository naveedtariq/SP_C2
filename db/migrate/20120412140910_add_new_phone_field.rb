class AddNewPhoneField < ActiveRecord::Migration
  def self.up
    remove_column :users, :phone
    add_column :users, :phone, :string

  end
  def self.down
    add_column :users, :phone, :integer
    remove_column :users, :phone
  end
end
