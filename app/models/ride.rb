class Ride < ActiveRecord::Base
  has_many :ride_participants
  has_many :users, :through => :ride_participants
  belongs_to :location
end
