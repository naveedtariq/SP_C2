require 'spec_helper'

describe "Signups" do
  it "shows user form when user clicks on signup from login page" do
    visit login_path
    click_link "Sign up"
    current_path.should eq(signup_path)
  end
end
