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
    click_link ('Ride search page')
    current_path.should eq(search_rides_path)
    select(Location.first.name, :from => "ride_from_location_id")
    select(Location.last.name, :from => "ride_to_location_id")
    click_button ('search')
    page.should have_content("No records")
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
    click_link ('Ride search page')
    current_path.should eq(search_rides_path)
    ride = Factory(:ride)
    select(Location.first.name, :from => "ride_from_location_id")
    select(Location.last.name, :from => "ride_to_location_id")
    click_button ('search')
    page.should have_content(Location.first.name)
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
    click_link ('Ride search page')
    current_path.should eq(search_rides_path)
    ride = Factory(:ride)
    select(Location.first.name, :from => "ride_from_location_id")
    select(Location.last.name, :from => "ride_to_location_id")
    choose('ride_departure_all')
    click_button ('search')
    page.should have_content(Location.first.name)
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
    click_link ('Ride search page')
    current_path.should eq(search_rides_path)
    ride = Factory(:ride)
    select(Location.first.name, :from => "ride_from_location_id")
    select(Location.last.name, :from => "ride_to_location_id")
    choose('ride_departure_first_option')
    click_button ('search')
    page.should have_content(Location.first.name)
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
    click_link ('Ride search page')
    current_path.should eq(search_rides_path)
    ride = Factory(:ride)
    select(Location.first.name, :from => "ride_from_location_id")
    select(Location.last.name, :from => "ride_to_location_id")
    choose('ride_departure_second_option')
    click_button ('search')
    page.should have_content(Location.first.name)
    current_path.should eq(search_rides_path)

  end
end
