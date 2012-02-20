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
      :from_city => "testcity",
      :to_city => "testcity2",
      :available_seats => 2,
      :price_per_seat => 2,
      :departure_datetime => Time.now,
      :arrival_datetime => Time.now,
      :ride_type => "sudan"
    }
  end
  def valid_post_hash_for_users
    {
      :password               => 'test password',
      :password_confirmation  => 'test password',
      :email                  => 'test@tester.com',
      :first_name                  => 'test',
      :last_name                  => 'me'
    }
  end
end
