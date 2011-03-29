Feature: List stories
  As a user
  I want to be able to see recent stories
  So that I may see the latest stories

  Scenario: See stories sorted by top
    Given there are "20" stories
    When I am on the homepage
    Then I should see "20" stories sorted by "top"

  Scenario: Stories are listed in proper order
    # pending
  
  @javascript
  Scenario: User can see past upvoted items
    Given the following users exist:
      | username    | password    |
      | caitlin     | caitlin123  |
      | not_caitlin | randomstuff |
      And the following stories exist:
        | title  | link                | user        | created_at          |
        | google | google.com/a1       | not_caitlin | 2011-01-01 10:12:23 |
        | yahoo  | mail.yahoo.com/kjxf | not_caitlin | 2011-02-03 10:12:23 |
        | excite | old.excite.com/     | not_caitlin | 2003-08-24 10:12:23 |
        | reddit | reddit.com/         | not_caitlin | 2009-06-12 10:12:23 |
        | digg   | digg.com/2341       | not_caitlin | 2010-11-08 10:12:23 |
      And I am logged in as "caitlin"
      And I am interacting with story titled "digg"
    When I display the story
      And I "upvote" the story
      And the story should be "upvoted"
      And I go to the homepage
    Then the story should be "upvoted"
      