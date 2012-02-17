class User < ActiveRecord::Base

  authenticates_with_sorcery!
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :about, :gender, :dob, :phone, :city, :town, :work, :title, :school

  has_many :ride_participants
  has_many :rides, :through => :ride_participants
  has_many :created_rides, :class_name => Ride
  validates_confirmation_of :password
  validates :password, :on => :create, :presence =>true
  validates :email, :presence =>true
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :password_confirmation, :presence =>true
  validates_uniqueness_of :email
  validates_format_of :email, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
end
