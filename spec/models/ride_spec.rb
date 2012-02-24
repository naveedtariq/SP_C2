require 'spec_helper'

describe Ride do
  before(:each) do
    @ride = Ride.new(valid_post_hash)
  end

  it "should be valid" do
    @ride.should be_valid
  end

  it "could have many users" do
    @ride.save!
    @user = @ride.users.create!(valid_post_hash_for_users)
    @ride.users.first.should eq @user
  end

  it "could have many ride participants" do
    @ride.save!
    @user = @ride.users.create!(valid_post_hash_for_users)
    @ride.ride_participants.first.user_id.should eq @user.id
  end
#
#  it "should have one location" do
#    @ride.save!
#    @location = Location.create!
#    @location.ride = @ride
#    @ride.location.id.should eq @location.id
#  end

  def valid_post_hash
    {
      :from_location_id => Location.first.id,
      :to_location_id => Location.last.id,
      :available_seats => 2,
      :total_price => 2,
      :departure_date => SpClock.date,
      :departure_time => SpClock.time,
      :duration_in_minutes => 15,
      :ride_type => "sudan"
    }
  end
  def valid_post_hash_for_users
    {
      :password               => 'test password',
      :password_confirmation  => 'test password',
      :email                  => 'test@tester.com',
      :first_name                  => 'test',
      :last_name                  => 'me',
      :photo => File.open("#{Rails.root}/spec/data/dont_delete.png"), 
    }
  end
end
