require 'spec_helper'

describe User do
  before(:each) do
    @ride = Ride.new
  end

  it "should be valid" do
    @ride.should be_valid
  end

  it "could have many users" do
    @ride.save!
    @user = @ride.users.create!(valid_post_hash)
    @ride.users.first.should eq @user
  end

  it "could have many ride participants" do
    @ride.save!
    @user = @ride.users.create!(valid_post_hash)
    @ride.ride_participants.first.user_id.should eq @user.id
  end

  it "should have one location" do
    @ride.save!
    @location = Location.create!
    @location.ride = @ride
    @ride.location.id.should eq @location.id
  end

  def valid_post_hash
    {
      :password               => 'test password',
      :password_confirmation  => 'test password',
      :email                  => 'test@tester.com'
    }
  end
end
