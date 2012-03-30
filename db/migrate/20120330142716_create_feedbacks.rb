class CreateFeedbacks < ActiveRecord::Migration
   def self.up
    create_table :feedbacks do |t|
      t.integer  :user_id
      t.integer  :owner_id
      t.integer  :ride_id
      t.text     :feedback
      t.string   :status
      t.timestamps
    end
  end

  def self.down
    drop_table :feedbacks do |t|
      t.integer  :user_id
      t.integer  :owner_id
      t.integer  :ride_id
      t.text     :feedback
      t.string   :status
      t.timestamps
    end
  end
end
