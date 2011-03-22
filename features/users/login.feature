Feature: User login
  As a user not logged in
  I want to be able to log in
  So that I may participate on the site
  
  Background:
    Given site has a user "Test_User" with password "pass123"
    
  Scenario: Guest logs in as a user
    Given I am not logged in
      And I am on the homepage
    When I follow "login"
      And I fill in "Username" with "Test_User"
      And I fill in "Password" with "pass123"
      And I press "Submit"
    Then I should be on the homepage
      And I should see "Successfully logged in."
      And I should see "Test_User" within ".username"
  
  Scenario: Guest can log out
    Given I am logged in as a user
    When I follow "logout"
    Then I should be on the homepage
      And I should see "Successfully logged out."
  
  
  