require 'spec_helper'

describe User do
  before(:each) do
    @user = User.new(valid_post_hash)
  end

  it "should be valid" do
    @user.should be_valid
  end

  it "should not be valid due to absence of password" do
    @user.password = ''
    @user.should_not be_valid
  end
  
  it "should not be valid due to absence of email" do
    @user.email = ''
    @user.should_not be_valid
  end

  it "should not be valid due to password miss match" do
    @user.password = 'miss match password' # changed password from 'test password' to 'miss match password'
    @user.should_not be_valid
  end

  it "should not be valid due to invalid email format" do
    @user.email = 'test@tester' # invalid email format
    @user.should_not be_valid
  end

  it "should not be valid due to email already been taken" do
    @user.email = 'test@tester.com' # valid email format
    @user.save!
    test_user = User.new(valid_post_hash)
    test_user.should_not be_valid
  end

  it "could have many rides" do
    @user.save!
    @ride = Ride.create!
    @user.rides << @ride
    @user.rides.first.should eq @ride
  end

  it "could have many rides participants" do
    @user.save!
    @ride = Ride.create!
    @user.rides << @ride
    @ride_participant = RideParticipant.where :user_id => @user.id, :ride_id => @ride.id
    @ride_participant.first.should eq(@user.ride_participants.first)
  end

  def valid_post_hash
    {
      :password               => 'test password',
      :password_confirmation  => 'test password',
      :email                  => 'test@tester.com'
    }
  end
end