class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :owner, :class_name => User
  belongs_to :ride
  scope :ordered, :order => "created_at ASC"
  scope :rev_ordered, :order => "created_at DESC"
end
