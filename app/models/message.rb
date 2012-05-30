class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :owner, :class_name => User
  belongs_to :ride
  scope :ordered, :order => "id ASC"
  scope :rev_ordered, :order => "id DESC"
end
