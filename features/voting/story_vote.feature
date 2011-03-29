Feature: Vote on stories
  As a user
  I want to be able to upvote or downvote a story
  So that I may contribute to controlling the site content
  
  Background: 
    Given the following users exist:
      | username     | password    |
      | caitlin      | caitlin123  |
      | not_caitlin  | randomstuff |
      And the following stories exist:
        | title  | link       | user        | created_at          |
        | google | google.com | not_caitlin | 2011-01-01 10:12:23 |
      And I am logged in as "caitlin"
    When I display the story

  Scenario: User sees voting buttons next to a story
    Then I should see "up" within ".story .scoring"
      And I should see "1" within ".story .score"
      And I should see "down" within ".story .scoring"
    
  @javascript
  Scenario: User can upvote a story
    When I follow "up" within ".story .scoring"
    Then I should see "2" within ".story .score"
      And "up" arrow is activated
  
  @javascript
  Scenario: A second upvote takes away the upvote
    When I follow "up" within ".story .scoring"
      And I follow "up" within ".story .scoring"
    Then I should see "1" within ".story .score"
      And "up" arrow is not activated
  
  @javascript
  Scenario: User can downvote a story
    When I follow "down" within ".story .scoring"
    Then I should see "0" within ".story .score"
      And "down" arrow is activated

  @javascript
  Scenario: A second downvote takes away the downvote
    When I follow "down" within ".story .scoring"
      And I follow "down" within ".story .scoring"
    Then I should see "1" within ".story .score"
      And "down" arrow is not activated



