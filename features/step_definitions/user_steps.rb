# -------------------------------------------------
#  Classes and methods for the step definitions
# -------------------------------------------------

def login(username, password)
  steps %Q{
    Given I am not logged in
      And I go to the login page
      And I fill in "Username" with "#{username}"
      And I fill in "Password" with "#{password}"
      And I press "Submit"
  }
  @current_user = User.find_by_username(username)
end

def register_user(username, password, options = {})
  options[:email] ||= "#{username}@test.com" 
  steps %Q{
    Given I am not logged in
      And I am on the new user page
      And I fill in "Username" with "#{username}"
      And I fill in "Email" with "#{options[:email]}"
      And I fill in "Password" with "#{password}"
      And I fill in "Password confirmation" with "#{password}"
      And I press "Submit"
      And I logout
  }
  {:username => username, :password => password}
end


# -------------------------------------------------
#  Step definitions
# -------------------------------------------------

Given /^I am not logged in$/ do
  steps %Q{ Given I logout } unless @current_user.nil?
  @current_user = nil
end


Given /^I logout$/ do
  steps %Q{ Given I follow "logout" }
  @current_user = nil
end


Given /^the following users exist:$/ do |users_table|
  @passwords = users_table.hashes.map do |user|
    register_user(user['username'], user['password'], {:email => user['email']})
  end
end     

Given /^I am logged in as "([^"]*)"$/ do |user|
  steps %Q{ Given I am not logged in }
  
  found_user = @passwords.select{|p| p[:username] == user }.first unless @passwords.nil?
  found_user = register_user user, 'pass123' if found_user.nil?
  
  login user, found_user[:password]
  
end

Given /^I am an admin$/ do
  @current_user.role = 'admin'
  @current_user.save
end

Then /^I should have role "([^"]*)"$/ do |role|
    assert_equal role, @current_user.role
end
