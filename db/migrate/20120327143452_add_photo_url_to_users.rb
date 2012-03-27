class AddPhotoUrlToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :photo_url, :string
    add_column :users, :oauth_code, :text
    remove_column :authentications, :employers

  end
  def self.down
    remove_column :users, :photo_url
    remove_column :users, :oauth_code
    add_column :authentications, :employers, :text

  end
end
