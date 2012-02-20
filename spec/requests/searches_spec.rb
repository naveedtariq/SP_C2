require 'spec_helper'

describe "Searches", :js => true do

    it "Show no Result found When searching city path not exist " do
    visit login_path
    @user = Factory(:user)
    fill_in "email", :with => @user.email
    fill_in "password", :with => "secret"
    click_button ('Log in')
    page.should have_content("Logged in!")
    current_path.should eq(root_path)
    click_link ('Search Rides')
    current_path.should eq(search_rides_path)
    fill_in "ride_from_city", :with => "test"
    fill_in "ride_to_city", :with => "test"
    click_button ('search')
    page.should have_content("No ride found")
    current_path.should eq(search_rides_path)
  end
    it "Show no Result found When searching city path not exist " do
    visit login_path
    @user = Factory(:user)
    fill_in "email", :with => @user.email
    fill_in "password", :with => "secret"
    click_button ('Log in')
    page.should have_content("Logged in!")
    current_path.should eq(root_path)
    click_link ('Search Rides')
    current_path.should eq(search_rides_path)
    ride = Factory(:ride)
    fill_in "ride_from_city", :with => ride.from_city
    fill_in "ride_to_city", :with => ride.to_city
    click_button ('search')
    page.should_not have_content("No ride found")
    page.should have_content(ride.from_city)
    current_path.should eq(search_rides_path)
  end

    it "Show the records When searching city path by all " do
    visit login_path
    @user = Factory(:user)
    fill_in "email", :with => @user.email
    fill_in "password", :with => "secret"
    click_button ('Log in')
    page.should have_content("Logged in!")
    current_path.should eq(root_path)
    click_link ('Search Rides')
    current_path.should eq(search_rides_path)
    ride = Factory(:ride)
    fill_in "ride_from_city", :with => ride.from_city
    fill_in "ride_to_city", :with => ride.to_city
    choose('ride_departure_datetime_all')
    click_button ('search')
    page.should have_content(ride.from_city)
    current_path.should eq(search_rides_path)
  end

    it "Show the records When searching city path by week " do
    visit login_path
    @user = Factory(:user)
    fill_in "email", :with => @user.email
    fill_in "password", :with => "secret"
    click_button ('Log in')
    page.should have_content("Logged in!")
    current_path.should eq(root_path)
    click_link ('Search Rides')
    current_path.should eq(search_rides_path)
    ride = Factory(:ride)
    fill_in "ride_from_city", :with => ride.from_city
    fill_in "ride_to_city", :with => ride.to_city
    choose('ride_departure_datetime_this_week')
    click_button ('search')
    page.should have_content(ride.from_city)
    current_path.should eq(search_rides_path)
  end

      it "Show the records When searching city path by month " do
    visit login_path
    @user = Factory(:user)
    fill_in "email", :with => @user.email
    fill_in "password", :with => "secret"
    click_button ('Log in')
    page.should have_content("Logged in!")
    current_path.should eq(root_path)
    click_link ('Search Rides')
    current_path.should eq(search_rides_path)
    ride = Factory(:ride)
    fill_in "ride_from_city", :with => ride.from_city
    fill_in "ride_to_city", :with => ride.to_city
    choose('ride_departure_datetime_this_month')
    click_button ('search')
    page.should have_content(ride.from_city)
    current_path.should eq(search_rides_path)
  end
end
