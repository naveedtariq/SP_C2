require 'spec_helper'

describe "Rides" do
  it "Show the form for the Rides Input" do
   
    visit login_path
    @user = Factory(:user)
    fill_in "email", :with => @user.email
    fill_in "password", :with => "secret"
    click_button ('Log in')
    page.should have_content("Logged in!")
    current_path.should eq(root_path)
    click_link ('New Ride')
    current_path.should eq(new_ride_path)
    page.should have_select('From city', :options => ['Afghanistan'])
    page.should have_select('To city', :options => ['Afghanistan'])
    fill_in "ride_flexibility", :with => "test"
    fill_in "ride_duration", :with => "test"
    fill_in "ride_available_seats", :with => "test"
    fill_in "ride_price_per_seat", :with => "test"
    fill_in "ride_notes", :with => "test"
    click_button ('Create Ride')
    page.should have_content("Successfully created ride.")
    current_path.should eq(root_path)
  end
end
