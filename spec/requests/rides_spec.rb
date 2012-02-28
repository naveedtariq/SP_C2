require 'spec_helper'

describe "Rides", :js =>true do
#  it "Show the Successfully created ride when all inputs to the ride" do
#    visit login_path
#    @user = Factory(:user)
#    fill_in "email", :with => @user.email
#    fill_in "password", :with => "secret"
#    click_button ('Sign in')
#    page.should have_content("Logged in!")
#    current_path.should eq(root_path)
#    click_link ('Ride input page')
#    current_path.should eq(new_ride_path)
#    select(Location.last.name, :from => "ride_from_location_id")
#    fill_in "ride_departure_date", :with => SpClock.date
#    choose('ride_ride_type_sedon')
#    fill_in "ride_total_price", :with => "12"
#    fill_in "ride_notes", :with => "test"
#    click_button ('Create Ride')
    #page.should have_content("Successfully created ride")
#    current_path.should eq(root_path)
#  end
#  it "From and to location can't be the same" do
#    visit login_path
#    @user = Factory(:user)
#    fill_in "email", :with => @user.email
#    fill_in "password", :with => "secret"
#    click_button ('Sign in')
#    page.should have_content("Logged in!")
#    current_path.should eq(root_path)
#    click_link ('Ride input page')
#    current_path.should eq(new_ride_path)
#    fill_in "ride_departure_date", :with => SpClock.date
#    choose('ride_ride_type_sedon')
#    fill_in "ride_total_price", :with => "12"
#    fill_in "ride_notes", :with => "test"
#    click_button ('Create Ride')
#    page.should have_content("From location can't be same as destination")
#    current_path.should eq(rides_path)
#  end
#
#    it "Should show Total price can't be blank and Total price is not a number when there no input to Price per Seat", :js => true do
#    visit login_path
#    @user = Factory(:user)
#    fill_in "email", :with => @user.email
#    fill_in "password", :with => "secret"
#    click_button ('Sign in')
#    page.should have_content("Logged in!")
#    current_path.should eq(root_path)
#    click_link ('Ride input page')
#    current_path.should eq(new_ride_path)
#    fill_in "ride_total_price", :with => ""
#    fill_in "ride_departure_date", :with => SpClock.date
#    fill_in "ride_notes", :with => "test"
#    click_button ('Create Ride')
#    page.should have_content("Total price can't be blank")
#    page.should have_content("Total price is not a number")
#    current_path.should eq(rides_path)
#  end
#
#      it "Should show Total price is not a number when we enter Alphabetics to Price per seat", :js => true do
#    visit login_path
#    @user = Factory(:user)
#    fill_in "email", :with => @user.email
#    fill_in "password", :with => "secret"
#    click_button ('Sign in')
#    page.should have_content("Logged in!")
#    current_path.should eq(root_path)
#    click_link ('Ride input page')
#    current_path.should eq(new_ride_path)
#    fill_in "ride_total_price", :with => "dsas"
#    fill_in "ride_departure_date", :with => SpClock.date
#    fill_in "ride_notes", :with => "test"
#    click_button ('Create Ride')
#    page.should have_content("Total price is not a number")
#    current_path.should eq(rides_path)
#  end
#
#    it "Should show Departure date can't be blank when there is no in put to departure date", :js => true do
#    visit login_path
#    @user = Factory(:user)
#    fill_in "email", :with => @user.email
#    fill_in "password", :with => "secret"
#    click_button ('Sign in')
#    page.should have_content("Logged in!")
#    current_path.should eq(root_path)
#    click_link ('Ride input page')
#    current_path.should eq(new_ride_path)
#    fill_in "ride_departure_date", :with => ""
#    fill_in "ride_total_price", :with => "12"
#    fill_in "ride_notes", :with => "test"
#    click_button ('Create Ride')
#    page.should have_content("Departure date can't be blank")
#    current_path.should eq(rides_path)
#  end
#
#  #---------------------------------------------------------------------------------------------
#    it "Should show Successfully Booked", :js => true do
#    visit login_path
#    @user = Factory(:user)
#    fill_in "email", :with => @user.email
#    fill_in "password", :with => "secret"
#    click_button ('Sign in')
#    page.should have_content("Logged in!")
#    current_path.should eq(root_path)
#    click_link ('Ride search page')
#    current_path.should eq(search_rides_path)
#    click_link ('Select')
#    click_button ('Book Ride')
#    fill_in "ride_participant_phone", :with => "4552254"
#    choose("ride_participant_mode_of_communications_phone_call")
#    click_button ('Booking Ride')
#    page.should have_content("Successfully Booked")
#    current_path.should eq(dashboard_path)
#  end
#
#--------------------------------- Booking Ride ------------------------------------------------
#
    it "Should Successfuly ride accepted", :js => true do
    visit login_path
    @user = Factory(:user)
    fill_in "email", :with => @user.email
    fill_in "password", :with => "secret"
    click_button ('Sign in')
    page.should have_content("Logged in!")
    current_path.should eq(root_path)
    click_link ('Ride input page')
    current_path.should eq(new_ride_path)
    select(Location.last.name, :from => "ride_from_location_id")
    fill_in "ride_departure_date", :with => SpClock.date
    choose('ride_ride_type_sedon')
    fill_in "ride_total_price", :with => "60  "
    fill_in "ride_notes", :with => "test"
    click_button ('Create Ride')
    page.should have_content("Successfully created ride")
    current_path.should eq(root_path)
    click_link('Log out')
    current_path.should eq(login_path)
    @user2 = Factory(:user)
    fill_in "email", :with => @user2.email
    fill_in "password", :with => "secret"
    click_button ('Sign in')
    page.should have_content("Logged in!")
    click_link ('Ride search page')
    current_path.should eq(search_rides_path)
    click_link ('Select')
    current_path.should eq('/rides/1/ride_participants/new')
    click_button ('Book Ride')
    fill_in "ride_participant_phone", :with => "4552254"
    choose("ride_participant_mode_of_communications_phone_call")
    click_button ('Booking Ride')
    page.should have_content("Successfully Booked")
    current_path.should eq(dashboard_path)
    click_link('Log out')
    current_path.should eq(login_path)
    fill_in "email", :with => @user.email
    fill_in "password", :with => "secret"
    click_button ('Sign in')
    page.should have_content("Logged in!")
    current_path.should eq(root_path)
    click_link ('My Dashboard')
    current_path.should eq(dashboard_path)
    #click_link ('Accept')
    visit '/rides/1/ride_participants/1/accept'
    current_path.should eq('/rides/1/ride_participants/1/accept')
  end
#------------------------------ Accept Ride -----------------------------------------------------

      it "Should Successfuly ride denied", :js => true do
    visit login_path
    @user = Factory(:user)
    fill_in "email", :with => @user.email
    fill_in "password", :with => "secret"
    click_button ('Sign in')
    page.should have_content("Logged in!")
    current_path.should eq(root_path)
    click_link ('Ride input page')
    current_path.should eq(new_ride_path)
    select(Location.last.name, :from => "ride_from_location_id")
    fill_in "ride_departure_date", :with => SpClock.date
    choose('ride_ride_type_sedon')
    fill_in "ride_total_price", :with => "60  "
    fill_in "ride_notes", :with => "test"
    click_button ('Create Ride')
    page.should have_content("Successfully created ride")
    current_path.should eq(root_path)
    click_link('Log out')
    current_path.should eq(login_path)
    @user2 = Factory(:user)
    fill_in "email", :with => @user2.email
    fill_in "password", :with => "secret"
    click_button ('Sign in')
    page.should have_content("Logged in!")
    click_link ('Ride search page')
    current_path.should eq(search_rides_path)
    click_link ('Select')
    current_path.should eq('/rides/1/ride_participants/new')
    click_button ('Book Ride')
    fill_in "ride_participant_phone", :with => "4552254"
    choose("ride_participant_mode_of_communications_phone_call")
    click_button ('Booking Ride')
    page.should have_content("Successfully Booked")
    current_path.should eq(dashboard_path)
    click_link('Log out')
    current_path.should eq(login_path)
    fill_in "email", :with => @user.email
    fill_in "password", :with => "secret"
    click_button ('Sign in')
    page.should have_content("Logged in!")
    current_path.should eq(root_path)
    click_link ('My Dashboard')
    current_path.should eq(dashboard_path)
    #click_link ('Deny')
    visit '/rides/1/ride_participants/1/deny'
    current_path.should eq('/rides/1/ride_participants/1/deny')
  end

# ----------------------------- Deny Ride -------------------------------------------------------
#
   it "Should Cancel the ride successfully", :js => true do
    visit login_path
    @user = Factory(:user)
    fill_in "email", :with => @user.email
    fill_in "password", :with => "secret"
    click_button ('Sign in')
    page.should have_content("Logged in!")
    current_path.should eq(root_path)
    click_link ('Ride input page')
    current_path.should eq(new_ride_path)
    select(Location.last.name, :from => "ride_from_location_id")
    fill_in "ride_departure_date", :with => SpClock.date
    choose('ride_ride_type_sedon')
    fill_in "ride_total_price", :with => "60  "
    fill_in "ride_notes", :with => "test"
    click_button ('Create Ride')
    current_path.should eq(root_path)
    click_link ('My Dashboard')
    current_path.should eq(dashboard_path)
    click_link ('Cancel ride')
    current_path.should eq(dashboard_path)
   end
#-------------------------------- Cancel Ride -------------------------------------------------

    it "Should show Ride was successfully updated.", :js => true do
    visit login_path
    @user = Factory(:user)
    fill_in "email", :with => @user.email
    fill_in "password", :with => "secret"
    click_button ('Sign in')
    page.should have_content("Logged in!")
    current_path.should eq(root_path)
    click_link ('Ride input page')
    current_path.should eq(new_ride_path)
    select(Location.last.name, :from => "ride_from_location_id")
    fill_in "ride_departure_date", :with => SpClock.date
    choose('ride_ride_type_sedon')
    fill_in "ride_total_price", :with => "60  "
    fill_in "ride_notes", :with => "test"
    click_button ('Create Ride')
    current_path.should eq(root_path)
    click_link ('My Dashboard')
    current_path.should eq(dashboard_path)
    click_link ('Modify ride')
    current_path.should eq('/rides/2/edit')
    click_button ('Create Ride')
    current_path.should eq(dashboard_path)
    page.should have_content("Ride was successfully updated.")
   end
#------------------------------------- Modify Ride ------------------------------------------------

end