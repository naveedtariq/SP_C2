class AddFriendListInterestsEmployersToAuthentications < ActiveRecord::Migration
  def change
    add_column :authentications, :friend_list, :text

    add_column :authentications, :interests, :text

    add_column :authentications, :employers, :string

  end
end
