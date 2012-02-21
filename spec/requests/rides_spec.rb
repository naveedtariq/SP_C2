require 'spec_helper'

describe "Rides", :js => true do
  it "Show the Records of input Rides" do
    visit login_path
    @user = Factory(:user)
    fill_in "email", :with => @user.email
    fill_in "password", :with => "secret"
    click_button ('Log in')
    page.should have_content("Logged in!")
    current_path.should eq(root_path)
    click_link ('Ride input page')
    current_path.should eq(new_ride_path)
    select(Location.last.name, :from => "ride_from_location_id")
    fill_in "ride_departure_date", :with => SpClock.date
    choose('ride_ride_type_sedon')
    fill_in "ride_price_per_seat", :with => "12"
    fill_in "ride_notes", :with => "test"
    click_button ('Create Ride')
    page.should have_content("Successfully created ride.")
    current_path.should eq(root_path)
  end
  it "From and to location can't be the same" do
    visit login_path
    @user = Factory(:user)
    fill_in "email", :with => @user.email
    fill_in "password", :with => "secret"
    click_button ('Log in')
    page.should have_content("Logged in!")
    current_path.should eq(root_path)
    click_link ('Ride input page')
    current_path.should eq(new_ride_path)
    fill_in "ride_departure_date", :with => SpClock.date
    choose('ride_ride_type_sedon')
    fill_in "ride_price_per_seat", :with => "12"
    fill_in "ride_notes", :with => "test"
    click_button ('Create Ride')
    page.should have_content("From location can't be same as destination")
    current_path.should eq(rides_path)
  end

    it "Should show Price per seat can't be blank and Price per seat is not a number when there no input to Price per Seat", :js => true do
    visit login_path
    @user = Factory(:user)
    fill_in "email", :with => @user.email
    fill_in "password", :with => "secret"
    click_button ('Log in')
    page.should have_content("Logged in!")
    current_path.should eq(root_path)
    click_link ('Ride input page')
    current_path.should eq(new_ride_path)
    fill_in "ride_departure_date", :with => SpClock.date
    fill_in "ride_price_per_seat", :with => ""
    fill_in "ride_notes", :with => "test"
    click_button ('Create Ride')
    page.should have_content("Price per seat can't be blank")
    page.should have_content("Price per seat is not a number")
    current_path.should eq(rides_path)
  end

      it "Should show Price per seat is not a number when we enter Alphabetics to Price per seat", :js => true do
    visit login_path
    @user = Factory(:user)
    fill_in "email", :with => @user.email
    fill_in "password", :with => "secret"
    click_button ('Log in')
    page.should have_content("Logged in!")
    current_path.should eq(root_path)
    click_link ('Ride input page')
    current_path.should eq(new_ride_path)
    fill_in "ride_departure_date", :with => SpClock.date
    fill_in "ride_price_per_seat", :with => "dsas"
    fill_in "ride_notes", :with => "test"
    click_button ('Create Ride')
    page.should have_content("Price per seat is not a number")
    current_path.should eq(rides_path)
  end

    it "Should show Departure date can't be blank when there is no in put to departure date", :js => true do
    visit login_path
    @user = Factory(:user)
    fill_in "email", :with => @user.email
    fill_in "password", :with => "secret"
    click_button ('Log in')
    page.should have_content("Logged in!")
    current_path.should eq(root_path)
    click_link ('Ride input page')
    current_path.should eq(new_ride_path)
    fill_in "ride_departure_date", :with => ""
    fill_in "ride_price_per_seat", :with => "12"
    fill_in "ride_notes", :with => "test"
    click_button ('Create Ride')
    page.should have_content("Departure date can't be blank")
    current_path.should eq(rides_path)
  end
end