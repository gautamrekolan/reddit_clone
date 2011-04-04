Feature: Comments
  As a user
  I want to be able leave comments on stories
  So that I interact with other users on the site
  
  Background:
    Given the following users exist:
      | username    | password   |
      | caitlin     | caitlin123 |
      | random_user | password   |
      And the following stories exist:
        | title  | link       | user        | created_at          |
        | google | google.com | random_user | 2011-01-01 10:12:23 |
      And I am logged in as "caitlin"
  
  # Leave comments
  
  Scenario: User can see the form to leave a comment
    When I am on the story page for "google.com"
    Then I should see "leave a comment" within "#comments_area form"
    
  Scenario: User can leave a comment
    Given I am on the story page for "google.com"
    When I fill in the following:
      | comment | This is a new comment. |
      And I press "submit"
    Then I should be on the story page for "google.com"
      And I should see "caitlin" within ".comment .details"
      And I should see "This is a new comment." within ".comment .text"

  
  
  
  
