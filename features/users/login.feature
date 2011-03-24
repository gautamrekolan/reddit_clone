Feature: User login
  As a user not logged in
  I want to be able to log in
  So that I may participate on the site
  
  Background:
    Given the following users exist:
      | username  | password |
      | Test_User | pass123  |
    
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
  
  Scenario: User can log out
    Given I am logged in as "Test_User"
    When I follow "logout"
    Then I should be on the homepage
      And I should see "Successfully logged out."
  
  
  