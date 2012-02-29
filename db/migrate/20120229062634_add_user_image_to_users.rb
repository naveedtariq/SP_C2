class AddUserImageToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :user_image, :string
    remove_column :users, :photo_file_name
    remove_column :users, :photo_content_type
    remove_column :users, :photo_file_size
    remove_column :users, :photo_updated_at

  end

  def self.down
    remove_column :users, :user_image
    add_column :users, :photo_file_name, :strinadd_columng
    add_column :users, :photo_content_type, :string
    add_column :users, :photo_file_size, :integer
    add_column :users, :photo_updated_at, :datetime
  end
end
