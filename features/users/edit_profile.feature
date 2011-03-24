Feature: User edit profile
  As a user
  I want to be edit my profile
  So that I may keep my information on the site update
  
  Background:
    Given I am logged in as "any_user"
  
  Scenario: User can get to the edit profile page
    Given I am on the homepage
      And I should see "edit profile" within "#user_nav"
    When I follow "edit profile"
    Then I should be on the edit user page
  
  Scenario: User can edit their profile
    # pending
  
  
  