class RideParticipant < ActiveRecord::Base
  
  after_find do |ride_participant|
    ride_participant.update_attribute(:role, ROLES_FOR_RIDES[:expired]) if(((ride_participant.created_at + 1.day) < SpClock.time) && (ride_participant.role == ROLES_FOR_RIDES[:pending]))
  end
  belongs_to :user
  belongs_to :ride
  scope :pending_participants, where(:role => ROLES_FOR_RIDES[:pending])
  scope :confirmed_participants, where(:role => ROLES_FOR_RIDES[:confirmed])
  scope :pending_or_confirmed, where(:role => [ROLES_FOR_RIDES[:confirmed], ROLES_FOR_RIDES[:pending]])
  scope :active_participants,lambda{ joins(:user).where(:role => [ROLES_FOR_RIDES[:confirmed], ROLES_FOR_RIDES[:pending], ROLES_FOR_RIDES[:owner]])}
  scope :owners, where(:role => ROLES_FOR_RIDES[:owner])
  scope :role_wise, order("role ASC")
  scope :current_rides, lambda {
    joins(:ride).
      where("rides.departure_date >= ?", SpClock.date)
  }
  scope :past_rides, lambda {
    joins(:ride).
      where("rides.departure_date < ?", SpClock.date)
  }
  def self.owner
    self.owners.first
  end
  def owner
    self.ride.owner
  end

  def confirmed_participants
    self.find(:role =>[:confirmed])
  end
  def cancel!
    if self.role == ROLES_FOR_RIDES[:owner]
      self.ride.change_owner!
    end
    self.role = ROLES_FOR_RIDES[:canceled]
    self.save!
  end
end
