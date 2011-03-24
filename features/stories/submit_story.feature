Feature: Submit story
  As a user
  I want to be able submit new stories
  So that I may contribute to the site content
  
  Background:
      And I am logged in as "Caitlin"
  
  Scenario: Go to new story form
    Given I am on the homepage
    When I follow "New Story"
    Then I should be on the new story page
  
  Scenario: Create a new story
    Given I am on the new story page
    When I fill in the following:
      | Title | New Story  |
      | Link  | google.com |
      And I press "Create Story"
    Then I should see "New Story"
      And I should see "google.com"
      And I should see "Caitlin"

  
