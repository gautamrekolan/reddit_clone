Feature: Vote on stories
  As a user
  I want to be able to upvote or downvote a story
  So that I may contribute to controlling the site content
  
  Background: 
    Given the following stories exist:
      | title  | link       | user    | created_at          |
      | google | google.com | caitlin | 2011-01-01 10:12:23 |
    When I display the story

  Scenario: User sees voting buttons next to a story
    Then I should see "up" within ".story .scoring"
      And I should see "1" within ".story .score"
      And I should see "down" within ".story .scoring"
    
  Scenario: User can upvote a story
  
  
  
  
  