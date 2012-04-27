class AddNewPhoneField < ActiveRecord::Migration
  def self.up
    remove_column :users, :phone
    add_column :users, :phone, :string

  end
  def self.down
    remove_column :users, :phone
    add_column :users, :phone, :integer
  end
end
