class User < ActiveRecord::Base

  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :about, :gender, :dob, :phone, :city, :town, :work, :title, :school, :photo, :user_image, :number_of_friends, :authentications_attributes, :photo_url

  authenticates_with_sorcery! do |config|                      # Authentication with sorcery gem
    config.authentications_class = Authentication
  end

  has_many :authentications, :dependent => :destroy            # Association with authentication model
  accepts_nested_attributes_for :authentications
  mount_uploader :user_image, UserImageUploader                # Carrierwave for Image upload

  has_many :ride_participants                                  # Association with ride_participant model
  has_many :rides, :through => :ride_participants              # Association with rides
  has_many :messages                                           # Association with messages

  has_many :owned_messages, :class_name => Message, :foreign_key => "owner_id"   # Add foreign key in messages table
  
  has_many :feedbacks                                          # Association feedback model
  has_many :owned_feedacks, :class_name => Feedback, :foreign_key => "owner_id"   # Add foreign key in feedbacks table

  def created_rides                                             # return the created rides
    Ride.where(:id => self.ride_participants_owners.pluck(:ride_id))
  end

  def ride_participants_owners                                # return the ride_participants which are rides owner
    if self.ride_participants.blank?
      self.ride_participants
    else
      self.ride_participants.owners
    end
  end

  def full_name                                               # return the full name of user
    "#{self.first_name} #{self.last_name}"
  end

  validates_confirmation_of :password                         # Validation of confirmation Password
  validates :password, :on => :create, :presence =>true       # validation of password
  validates :email, :presence =>true                          # validation of email
  validates :first_name, :presence => true                    # validation of user's first_name
  validates :last_name, :presence => true                     # validates of user's last_name
  validates :password_confirmation, :presence =>true          # validates of password_confiramtion
  validates_uniqueness_of :email                              # validate of unique email
  validates_format_of :email, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i        # Validation of correct formate of email


  def user_image_url                                       # return the user image
    ((self.user_image.present?)?(self.user_image.url.to_s):nil) || self.photo_url || "/assets/no-image.png"
  end
  
#  def all_messages
#    messages = []
#    messages << self.messages
#    messages << self.owned_messages
#    messages.flatten!
#  end
end
