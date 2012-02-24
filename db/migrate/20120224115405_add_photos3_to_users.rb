class AddPhotos3ToUsers < ActiveRecord::Migration
  def change
    add_column :users, :photoS3, :string

  end
end
