require 'spec_helper'

describe "Rides" do
  it "Show the form for the Rides Input With no wrong input" do
   
    visit login_path
    @user = Factory(:user)
    fill_in "email", :with => @user.email
    fill_in "password", :with => "secret"
    click_button ('Log in')
    page.should have_content("Logged in!")
    current_path.should eq(root_path)
    click_link ('New Ride')
    current_path.should eq(new_ride_path)
    fill_in "ride_from_city", :with => "test"
    fill_in "ride_to_city", :with => "test"
    fill_in "ride_departure_datetime", :with => "2012-02-17 23:44:52"
    fill_in "ride_flexibility", :with => "12"
    fill_in "ride_arrival_datetime", :with => "2012-02-17 23:44:52"
    choose('ride_ride_type_sedon')
    fill_in "ride_available_seats", :with => "21"
    fill_in "ride_price_per_seat", :with => "12"
    fill_in "ride_notes", :with => "test"
    click_button ('Create Ride')
    page.should have_content("Successfully created ride.")
    current_path.should eq(root_path)
  end

    it "Should show From city can't be blank if there no ipnut of From city field" do
    visit login_path
    @user = Factory(:user)
    fill_in "email", :with => @user.email
    fill_in "password", :with => "secret"
    click_button ('Log in')
    page.should have_content("Logged in!")
    current_path.should eq(root_path)
    click_link ('New Ride')
    current_path.should eq(new_ride_path)
    fill_in "ride_from_city", :with => ""
    fill_in "ride_to_city", :with => "test"
    fill_in "ride_departure_datetime", :with => "2012-02-17 23:44:52"
    fill_in "ride_flexibility", :with => "12"
    fill_in "ride_arrival_datetime", :with => "2012-02-17 23:44:52"
    choose('ride_ride_type_sedon')
    fill_in "ride_available_seats", :with => "21"
    fill_in "ride_price_per_seat", :with => "12"
    fill_in "ride_notes", :with => "test"
    click_button ('Create Ride')
    page.should have_content("From city can't be blank")
    current_path.should eq(rides_path)
  end

      it "Should show To city can't be blank if there no ipnut of To city field" do
    visit login_path
    @user = Factory(:user)
    fill_in "email", :with => @user.email
    fill_in "password", :with => "secret"
    click_button ('Log in')
    page.should have_content("Logged in!")
    current_path.should eq(root_path)
    click_link ('New Ride')
    current_path.should eq(new_ride_path)
    fill_in "ride_from_city", :with => "test"
    fill_in "ride_to_city", :with => ""
    fill_in "ride_departure_datetime", :with => "2012-02-17 23:44:52"
    fill_in "ride_flexibility", :with => "12"
    fill_in "ride_arrival_datetime", :with => "2012-02-17 23:44:52"
    choose('ride_ride_type_sedon')
    fill_in "ride_available_seats", :with => "21"
    fill_in "ride_price_per_seat", :with => "12"
    fill_in "ride_notes", :with => "test"
    click_button ('Create Ride')
    page.should have_content("To city can't be blank")
    current_path.should eq(rides_path)
  end

    it "Should show Flexibilty is not a number if no flexibilty is se" do
    visit login_path
    @user = Factory(:user)
    fill_in "email", :with => @user.email
    fill_in "password", :with => "secret"
    click_button ('Log in')
    page.should have_content("Logged in!")
    current_path.should eq(root_path)
    click_link ('New Ride')
    current_path.should eq(new_ride_path)
    fill_in "ride_from_city", :with => "test"
    fill_in "ride_to_city", :with => "test"
    fill_in "ride_departure_datetime", :with => "2012-02-17 23:44:52"
    fill_in "ride_flexibility", :with => ""
    fill_in "ride_arrival_datetime", :with => "2012-02-17 23:44:52"
    choose('ride_ride_type_sedon')
    fill_in "ride_available_seats", :with => "21"
    fill_in "ride_price_per_seat", :with => "12"
    fill_in "ride_notes", :with => "test"
    click_button ('Create Ride')
    page.should have_content("Flexibility is not a number")
    current_path.should eq(rides_path)
  end

    it "Should show Departure datetime can't be blank if no input of Departure datetime" do
    visit login_path
    @user = Factory(:user)
    fill_in "email", :with => @user.email
    fill_in "password", :with => "secret"
    click_button ('Log in')
    page.should have_content("Logged in!")
    current_path.should eq(root_path)
    click_link ('New Ride')
    current_path.should eq(new_ride_path)
    fill_in "ride_from_city", :with => "test"
    fill_in "ride_to_city", :with => "test"
    fill_in "ride_departure_datetime", :with => ""
    fill_in "ride_flexibility", :with => "12"
    fill_in "ride_arrival_datetime", :with => "2012-02-17 23:44:52"
    choose('ride_ride_type_sedon')
    fill_in "ride_available_seats", :with => "21"
    fill_in "ride_price_per_seat", :with => "12"
    fill_in "ride_notes", :with => "test"
    click_button ('Create Ride')
    page.should have_content("Departure datetime can't be blank")
    current_path.should eq(rides_path)
  end

    it "Should show Arrival datetime can't be blank if no input of Arrival datetime" do
    visit login_path
    @user = Factory(:user)
    fill_in "email", :with => @user.email
    fill_in "password", :with => "secret"
    click_button ('Log in')
    page.should have_content("Logged in!")
    current_path.should eq(root_path)
    click_link ('New Ride')
    current_path.should eq(new_ride_path)
    fill_in "ride_from_city", :with => "test"
    fill_in "ride_to_city", :with => "test"
    fill_in "ride_departure_datetime", :with => "2012-02-17 23:44:52"
    fill_in "ride_flexibility", :with => "12"
    fill_in "ride_arrival_datetime", :with => ""
    choose('ride_ride_type_sedon')
    fill_in "ride_available_seats", :with => "21"
    fill_in "ride_price_per_seat", :with => "12"
    fill_in "ride_notes", :with => "test"
    click_button ('Create Ride')
    page.should have_content("Arrival datetime can't be blank")
    current_path.should eq(rides_path)
  end

    it "Should show Available seats can't be blank and Available seats is not a number when there no input to Available Seats " do
    visit login_path
    @user = Factory(:user)
    fill_in "email", :with => @user.email
    fill_in "password", :with => "secret"
    click_button ('Log in')
    page.should have_content("Logged in!")
    current_path.should eq(root_path)
    click_link ('New Ride')
    current_path.should eq(new_ride_path)
    fill_in "ride_from_city", :with => "test"
    fill_in "ride_to_city", :with => "test"
    fill_in "ride_departure_datetime", :with => "2012-02-17 23:44:52"
    fill_in "ride_flexibility", :with => "12"
    fill_in "ride_arrival_datetime", :with => "2012-02-17 23:44:52"
    choose('ride_ride_type_sedon')
    fill_in "ride_available_seats", :with => ""
    fill_in "ride_price_per_seat", :with => "12"
    fill_in "ride_notes", :with => "test"
    click_button ('Create Ride')
    page.should have_content("Available seats can't be blank")
    page.should have_content("Available seats is not a number")
    current_path.should eq(rides_path)
  end

  it "Should show Available seats must be greater than 0 when we enter 0 to Available seats" do
    visit login_path
    @user = Factory(:user)
    fill_in "email", :with => @user.email
    fill_in "password", :with => "secret"
    click_button ('Log in')
    page.should have_content("Logged in!")
    current_path.should eq(root_path)
    click_link ('New Ride')
    current_path.should eq(new_ride_path)
    fill_in "ride_from_city", :with => "test"
    fill_in "ride_to_city", :with => "test"
    fill_in "ride_departure_datetime", :with => "2012-02-17 23:44:52"
    fill_in "ride_flexibility", :with => "12"
    fill_in "ride_arrival_datetime", :with => "2012-02-17 23:44:52"
    choose('ride_ride_type_sedon')
    fill_in "ride_available_seats", :with => "0"
    fill_in "ride_price_per_seat", :with => "12"
    fill_in "ride_notes", :with => "test"
    click_button ('Create Ride')
    page.should have_content("Available seats must be greater than 0")
    current_path.should eq(rides_path)
  end

    it "Should show Available seats is not a number when we enter Alphabetics to Available seats" do
    visit login_path
    @user = Factory(:user)
    fill_in "email", :with => @user.email
    fill_in "password", :with => "secret"
    click_button ('Log in')
    page.should have_content("Logged in!")
    current_path.should eq(root_path)
    click_link ('New Ride')
    current_path.should eq(new_ride_path)
    fill_in "ride_from_city", :with => "test"
    fill_in "ride_to_city", :with => "test"
    fill_in "ride_departure_datetime", :with => "2012-02-17 23:44:52"
    fill_in "ride_flexibility", :with => "12"
    fill_in "ride_arrival_datetime", :with => "2012-02-17 23:44:52"
    choose('ride_ride_type_sedon')
    fill_in "ride_available_seats", :with => "gfg"
    fill_in "ride_price_per_seat", :with => "12"
    fill_in "ride_notes", :with => "test"
    click_button ('Create Ride')
    page.should have_content("Available seats is not a number")
    current_path.should eq(rides_path)
  end

    it "Should show Price per seat can't be blank and Price per seat is not a number when there no input to Price per Seat " do
    visit login_path
    @user = Factory(:user)
    fill_in "email", :with => @user.email
    fill_in "password", :with => "secret"
    click_button ('Log in')
    page.should have_content("Logged in!")
    current_path.should eq(root_path)
    click_link ('New Ride')
    current_path.should eq(new_ride_path)
    fill_in "ride_from_city", :with => "test"
    fill_in "ride_to_city", :with => "test"
    fill_in "ride_departure_datetime", :with => "2012-02-17 23:44:52"
    fill_in "ride_flexibility", :with => "12"
    fill_in "ride_arrival_datetime", :with => "2012-02-17 23:44:52"
    choose('ride_ride_type_sedon')
    fill_in "ride_available_seats", :with => "12"
    fill_in "ride_price_per_seat", :with => ""
    fill_in "ride_notes", :with => "test"
    click_button ('Create Ride')
    page.should have_content("Price per seat can't be blank")
    page.should have_content("Price per seat is not a number")
    current_path.should eq(rides_path)
  end

  it "Should show Price per seat is not a number when we enter Alphabetics to Price per seat" do
    visit login_path
    @user = Factory(:user)
    fill_in "email", :with => @user.email
    fill_in "password", :with => "secret"
    click_button ('Log in')
    page.should have_content("Logged in!")
    current_path.should eq(root_path)
    click_link ('New Ride')
    current_path.should eq(new_ride_path)
    fill_in "ride_from_city", :with => "test"
    fill_in "ride_to_city", :with => "test"
    fill_in "ride_departure_datetime", :with => "2012-02-17 23:44:52"
    fill_in "ride_flexibility", :with => "12"
    fill_in "ride_arrival_datetime", :with => "2012-02-17 23:44:52"
    choose('ride_ride_type_sedon')
    fill_in "ride_available_seats", :with => "0"
    fill_in "ride_price_per_seat", :with => "dsds"
    fill_in "ride_notes", :with => "test"
    click_button ('Create Ride')
    page.should have_content("Price per seat is not a number")
    current_path.should eq(rides_path)
  end
end
