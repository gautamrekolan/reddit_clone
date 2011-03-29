Feature: Story Information
  As a user
  I want to be able to see info and actions for each story
  So that I may be able to interact with the site


  # INFORMATION
  
  Background:
    Given the following users exist:
      | username | password   |
      | caitlin  | caitlin123 |
      And the following stories exist:
        | title  | link       | user    | created_at          |
        | google | google.com | caitlin | 2011-01-01 10:12:23 |
      And I am logged in as "caitlin"
  
  Scenario: See appropriate data in a story
    Given the current time is "2011-01-29 10:34:35"
    When I display the story
    Then I should see "google" within ".story .title"
      And I should see "google.com" within ".story .site"
      And I should see "caitlin" within ".story .details .user"
      And I should see "28 days" within ".story .details .date"
  
  Scenario Outline: Story titles should be a link to the story link
    Given the following stories exist:
      | title  | link       | user    | created_at          |
      | google | <link>     | caitlin | 2011-01-01 10:12:23 |
    When I display the story
    Then I should see "google" within ".story .title"  
      And "google" should be a link to "<display_link>"
  
      Scenarios: Links display with http://
        | link                  | display_link          |
        | google.com            | http://google.com     |
        | www.google.com        | http://www.google.com |
        | www.google.com        | http://www.google.com |
        | http://www.google.com | http://www.google.com |
  
  Scenario: Story should show domain in the site parenthesis, and link to the site
    Given the following stories exist:
      | title  | link                                      | user    | created_at          |
      | google | http://google.com/more/stuff/after/domain | caitlin | 2011-01-01 10:12:23 |
    When I display the story
    Then I should see "(google.com)" within ".story .site"
      And "google.com" should be a link to "http://google.com"
    

  Scenario Outline: Show appropriate time ago in words for a story date
    Given the current time is "<current_time>"
      And the following stories exist:
        | title  | link       | user    | created_at           |
        | google | google.com | caitlin | 2010-01-01 00:00:00  |
    When I display the story
    Then I should see "<time_in_words>" within ".date"

    # don't need to test extensively since it's a rails helper
    # just enough to make sure it's working correctly
    Scenarios: time gets converted to time ago
      | current_time        | time_in_words |
      | 2010-01-01 00:01:00 | 1 minute      |
      | 2010-01-01 00:05:00 | 5 minutes     |
      | 2010-01-01 00:50:00 | about 1 hour  |
      | 2010-01-01 05:00:00 | 5 hours       |
      | 2010-01-02 00:00:00 | 1 day         |
      | 2010-01-06 00:00:00 | 5 days        |
      | 2010-02-01 00:00:00 | about 1 month |
      | 2010-06-01 00:00:00 | 5 months      |
      | 2011-01-01 00:00:00 | about 1 year  |
  
  # ACTIONS
  
  Scenario: Stories have a link to the story thread
    Given the following stories exist:
      | title  | link       | user    | created_at          |
      | google | google.com | caitlin | 2011-01-01 10:12:23 |
    When I display the story
    Then I should see "link" within ".story .actions"  
    When I follow "link"
    Then I should be viewing the story
  
  Scenario: Story owner can edit or delete one of their stories
    When I display the story
    Then I should see "edit" within ".story .actions"
      And I should see "delete" within ".story .actions"
    
  Scenario: One user can't edit or delete another user's story
    Given I am logged in as "not_caitlin"
    When I display the story
    Then I should not see "edit" within ".story .actions"
      And I should not see "delete" within ".story .actions"

  