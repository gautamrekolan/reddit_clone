Feature: Guest has limited access to features
  As a guest
  I need to have limited access
  So that I cannot create content on the site without tying it to me
  
  Background:
    Given I am not logged in

  Scenario: Guest can't see new story link
    When I am on the homepage
    Then I should not see "New Story" within "a"

  Scenario: Guest can't access new story form
    When I go to the new story page
    Then I should be on the homepage
      And I should see "You must be logged in to do that."
