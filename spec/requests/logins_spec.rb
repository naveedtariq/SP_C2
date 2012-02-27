require 'spec_helper'

describe "Logins", :js => true do
  it "shows home page when user logins sucessfully" do
    @user = Factory(:user)
    visit login_path
    fill_in "email", :with => @user.email
    fill_in "password", :with => "secret"
    click_button ('Sign in')
    page.should have_content("Logged in!")
    current_path.should eq(root_path)
    
  end

    it "Shows Email or password was invalid with wrong credentials" do
    @user = Factory(:user)
    visit login_path
    fill_in "email", :with => @user.email
    fill_in "password", :with => ""
    click_button ('Sign in')
    page.should have_content("Email or password was invalid")
    current_path.should eq(sessions_path)
  end
end
