Feature: Guest signs up
  As a guest
  I want to be able to sign up
  So that I may participate on the site
  
  Background:
    Given I am not logged in
  
  Scenario: Guest can get to sign up form
    When I go to the homepage
      Then I should see "sign up" within "#user_nav"
    When I follow "sign up"
      Then I should be on the new user page
    
  Scenario: Guest should see appropriate fields in signup form
    Given I am on the new user page
    Then I should see "Username"
      And I should see "Email"
      And I should see "Password"
      And I should see "Password confirmation"
      And I should not see "Role"
  
  Scenario: Guest signs up
    Given I am on the new user page
    When I fill in "Username" with "myusername"
      And I fill in "Email" with "user@test.com"
      And I fill in "Password" with "password123"
      And I fill in "Password confirmation" with "password123"
      And I press "Sign up"
    Then I should be on the homepage
      And I should see "Registration successful."
      And I should see "1" within "#user_nav .karma"
      
  Scenario: New user should have user role
    Given the following users exist:
      | username | password |
      | test2    | test123  |
      And I am logged in as "test2"
    Then I should have role "user"

  Scenario: Guest cancels sign up
    Given I am on the new user page
    When I follow "Back"
    Then I should be on the homepage
  
  
  