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
  Scenario Outline: User votes once on a story
    When I "<up_or_down>vote" the story
    Then the story should have "<score>" points
      And the story should be "<vote>"
  
    Scenarios: Vote is up
      | up_or_down | score | vote      |
      | up         | 2     | upvoted   |

    Scenarios: Vote is down
      | up_or_down | score | vote      |
      | down       | 0     | downvoted |

  @javascript
  Scenario Outline: User votes twice on a story
    When I "<up_or_down_1>vote" the story
      And I "<up_or_down_2>vote" the story
    Then the story should have "<score>" points
      And the story should be "<vote>"

    Scenarios: First vote is up
      | up_or_down_1 | up_or_down_2 | score | vote      |
      | up           | down         | 0     | downvoted |
      | up           | up           | 1     | not voted |
      
    Scenarios: First vote is down
      | up_or_down_1 | up_or_down_2 | score | vote      |
      | down         | down         | 1     | not voted |
      | down         | up           | 2     | upvoted   |
