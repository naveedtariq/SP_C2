class RideParticipant < ActiveRecord::Base
  belongs_to :user
  belongs_to :ride
  scope :owners, where(:role => ROLES_FOR_RIDES[:owner])
  def self.owner
    self.owners.first
  end
end
