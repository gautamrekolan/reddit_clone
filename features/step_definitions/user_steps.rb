# -------------------------------------------------
#  Classes and methods for the step definitions
# -------------------------------------------------

def login(username, password)
  steps %Q{
    Given site has a user "#{username}" with password "#{password}"
      And I go to the login page
      And I fill in "Username" with "#{username}"
      And I fill in "Password" with "#{password}"
      And I press "Submit"
  }
end


# -------------------------------------------------
#  Step definitions
# -------------------------------------------------

Given /^I am not logged in$/ do
  @user = nil
end


Given /^site has a user "([^"]*)" with email "([^"]*)" and password "([^"]*)"$/ do |username, email, password|
  @user = User.create(:username => username,             
                      :email => email,
                      :password => password, 
                      :password_confirmation => password, 
                      :role => 'user')
  @given_username = username
  @given_password = password
end  

Given /^site has a user "([^"]*)" with password "([^"]*)"$/ do |username, password|
  @user = User.create(:username => username,             
                      :email => "#{username}@test.com",
                      :password => password, 
                      :password_confirmation => password, 
                      :role => 'user')
  @given_username = username
  @given_password = password
end            
       
                      
Given /^I am logged in as "([^"]*)" with password "([^"]*)"$/ do |username, password|
  login username, password
end

Given /^I am logged in$/ do
  login @given_username, @given_password
end

Given /^I am logged in as a user$/ do
  login "test_user", "pass123"           
end

Given /^I am an admin$/ do
  @user.role = 'admin'
  @user.save
end
