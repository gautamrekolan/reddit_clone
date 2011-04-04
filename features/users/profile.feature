Feature: User edit profile
  As a user
  I want to be edit my profile
  So that I may keep my information on the site update
  
  Background:
    Given the following users exist:
      | username    | password   | email            |
      | caitlin     | caitlin123 | caitlin@test.com |
      | not_caitlin | doot123    | notnot@test.com  |
  
  Scenario: User can get to the edit profile page
    Given I am logged in as "caitlin"
      And I am on the homepage
      And I should see "edit profile" within "#user_nav"
    When I follow "edit profile"
    Then I should be on the edit profile page for "caitlin"
  
  Scenario: User can edit their own profile
    Given I am logged in as "caitlin"
      And I go to the edit profile page for "caitlin"
    When I fill in the following:
      | Username              | new_caitlin          |
      | Email                 | new_caitlin@test.com |
      | Password              | newpass1             |
      | Password confirmation | newpass1             |
      And I press "Submit"
    Then I should be on the profile page for "new_caitlin"
      And I should see "Successfully updated profile."
      And I should see "new_caitlin" within ".username"

  Scenario: User cannot edit someone else's profile
    Given I am logged in as "caitlin"
    When I go to the edit profile page for "not_caitlin"
    Then I should be on the homepage
      And I should see "You do not have permission to do that."

  Scenario: User has a profile page
    When I go to the profile page for "caitlin"
    Then I should see "caitlin" within ".username"
      And I should see "karma" within ".karma"
  