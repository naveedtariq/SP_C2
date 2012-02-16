require 'spec_helper'

describe "Logouts" do
  it "Should Logout Sucessfully" do
  @user = Factory(:user)
  visit login_path
  fill_in "email", :with => @user.email
  fill_in "password", :with => "secret"
  click_button ('Log in')
  page.should have_content("Logged in!")
  current_path.should eq(root_path)
  click_link('Log out')
  page.should have_content("Logged out!")
  current_path.should eq(root_path)
  end
end
