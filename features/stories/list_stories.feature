Feature: List stories
  As a user
  I want to be able to see recent stories
  So that I may see the latest stories

  Scenario: See stories sorted by top
    Given there are 20 stories
    When I am on the homepage
    Then I should see 20 stories sorted by "top"

  Scenario: Stories are listed in proper order
    # pending
  
  
  