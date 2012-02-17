require 'spec_helper'

describe "Signups", :js => true do
  it "shows user form when user clicks on signup from login page" do
    visit login_path
    click_link "Sign up"
    current_path.should eq(signup_path)
  end

  it "Fill user information when user clicks on signup from login page" do
    visit signup_path
    fill_in "user_first_name", :with => "test1"
    fill_in "user_last_name", :with => "test2"
    fill_in "user_about", :with => "test "
    fill_in "user_email", :with => "testmail@test.com"
    fill_in "user_password", :with => "test"
    fill_in "user_password_confirmation", :with => "test"
    page.should have_select('Gender', :options => ['Male'])
    fill_in "user_phone", :with => "6545454"
    fill_in "user_city", :with => "test"
    fill_in "user_town", :with => "test"
    fill_in "user_work", :with => "test"
    fill_in "user_title", :with => "test"
    fill_in "user_school", :with => "test"
    current_path.should eq(signup_path)
  end

  it "Show First name can't be blank" do
    visit signup_path
    fill_in "user_first_name", :with => ""
    fill_in "user_last_name", :with => "test2"
    fill_in "user_about", :with => "test "
    fill_in "user_email", :with => "testmail@test.com"
    fill_in "user_password", :with => "test"
    fill_in "user_password_confirmation", :with => "test"
    page.should have_select('Gender', :options => ['Male'])
    fill_in "user_phone", :with => "6545454"
    fill_in "user_city", :with => "test"
    fill_in "user_town", :with => "test"
    fill_in "user_work", :with => "test"
    fill_in "user_title", :with => "test"
    fill_in "user_school", :with => "test"
    click_button ('Create User')
    page.should have_content("First name can't be blank")
    current_path.should eq(users_path)
  end

  it "Show Last name can't be blank" do
    visit signup_path
    fill_in "user_first_name", :with => "test"
    fill_in "user_last_name", :with => ""
    fill_in "user_about", :with => "test "
    fill_in "user_email", :with => "testmail@test.com"
    fill_in "user_password", :with => "test"
    fill_in "user_password_confirmation", :with => "test"
    page.should have_select('Gender', :options => ['Male'])
    fill_in "user_phone", :with => "6545454"
    fill_in "user_city", :with => "test"
    fill_in "user_town", :with => "test"
    fill_in "user_work", :with => "test"
    fill_in "user_title", :with => "test"
    fill_in "user_school", :with => "test"
    click_button ('Create User')
    page.should have_content("Last name can't be blank")
    current_path.should eq(users_path)
  end

  it "Show Email can't be blank" do
    visit signup_path
    fill_in "user_first_name", :with => "test"
    fill_in "user_last_name", :with => "test2"
    fill_in "user_about", :with => "test "
    fill_in "user_email", :with => ""
    fill_in "user_password", :with => "test"
    fill_in "user_password_confirmation", :with => "test"
    page.should have_select('Gender', :options => ['Male'])
    fill_in "user_phone", :with => "6545454"
    fill_in "user_city", :with => "test"
    fill_in "user_town", :with => "test"
    fill_in "user_work", :with => "test"
    fill_in "user_title", :with => "test"
    fill_in "user_school", :with => "test"
    click_button ('Create User')
    page.should have_content("Email can't be blank")
    current_path.should eq(users_path)
  end

  it "Show Email is Invalid" do
    visit signup_path
    fill_in "user_first_name", :with => "test"
    fill_in "user_last_name", :with => "test2"
    fill_in "user_about", :with => "test "
    fill_in "user_email", :with => "test.com"
    fill_in "user_password", :with => "test"
    fill_in "user_password_confirmation", :with => "test"
    page.should have_select('Gender', :options => ['Male'])
    fill_in "user_phone", :with => "6545454"
    fill_in "user_city", :with => "test"
    fill_in "user_town", :with => "test"
    fill_in "user_work", :with => "test"
    fill_in "user_title", :with => "test"
    fill_in "user_school", :with => "test"
    click_button ('Create User')
    page.should have_content("Email is invalid")
    current_path.should eq(users_path)
  end

  it "Show Password doesn't match confirmation & Password can't be blank" do
    visit signup_path
    fill_in "user_first_name", :with => "test"
    fill_in "user_last_name", :with => "test2"
    fill_in "user_about", :with => "test "
    fill_in "user_email", :with => "test.com"
    fill_in "user_password", :with => ""
    fill_in "user_password_confirmation", :with => "test"
    page.should have_select('Gender', :options => ['Male'])
    fill_in "user_phone", :with => "6545454"
    fill_in "user_city", :with => "test"
    fill_in "user_town", :with => "test"
    fill_in "user_work", :with => "test"
    fill_in "user_title", :with => "test"
    fill_in "user_school", :with => "test"
    click_button ('Create User')
    page.should have_content("Password doesn't match confirmation")
    page.should have_content("Password can't be blank")
    current_path.should eq(users_path)
  end

  it "Show Password doesn't match confirmation & Password confirmation can't be blank" do
    visit signup_path
    fill_in "user_first_name", :with => "test"
    fill_in "user_last_name", :with => "test2"
    fill_in "user_about", :with => "test "
    fill_in "user_email", :with => "test.com"
    fill_in "user_password", :with => "test"
    fill_in "user_password_confirmation", :with => ""
    page.should have_select('Gender', :options => ['Male'])
    fill_in "user_phone", :with => "6545454"
    fill_in "user_city", :with => "test"
    fill_in "user_town", :with => "test"
    fill_in "user_work", :with => "test"
    fill_in "user_title", :with => "test"
    fill_in "user_school", :with => "test"
    click_button ('Create User')
    page.should have_content("Password doesn't match confirmation")
    page.should have_content("Password confirmation can't be blank")
    current_path.should eq(users_path)
  end

  it "Show Password doesn't match confirmation" do
    visit signup_path
    fill_in "user_first_name", :with => "test"
    fill_in "user_last_name", :with => "test2"
    fill_in "user_about", :with => "test "
    fill_in "user_email", :with => "test.com"
    fill_in "user_password", :with => "test"
    fill_in "user_password_confirmation", :with => "test1"
    page.should have_select('Gender', :options => ['Male'])
    fill_in "user_phone", :with => "6545454"
    fill_in "user_city", :with => "test"
    fill_in "user_town", :with => "test"
    fill_in "user_work", :with => "test"
    fill_in "user_title", :with => "test"
    fill_in "user_school", :with => "test"
    click_button ('Create User')
    page.should have_content("Password doesn't match confirmation")
    current_path.should eq(users_path)
  end

  it "Show Email has already been taken" do
    @user = Factory(:user)
    visit signup_path
    fill_in "user_first_name", :with => "test"
    fill_in "user_last_name", :with => "test"
    fill_in "user_about", :with => "test "
    fill_in "user_email", :with => User.first.email
    fill_in "user_password", :with => "test"
    fill_in "user_password_confirmation", :with => "test"
    page.should have_select('Gender', :options => ['Male'])
    fill_in "user_phone", :with => "6545454"
    fill_in "user_city", :with => "test"
    fill_in "user_town", :with => "test"
    fill_in "user_work", :with => "test"
    fill_in "user_title", :with => "test"
    fill_in "user_school", :with => "test"
    click_button ('Create User')
    page.should have_content("Email has already been taken")
    current_path.should eq(users_path)
  end

end
