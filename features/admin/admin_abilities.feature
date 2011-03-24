Feature: Admin abilities
  As an admin
  I want to be able manage the site's content
  So that I may keep the site in order

  Scenario: Admin can manage a story that's not theirs
    Given the following stories exist:
      | title  | link       | user        | created_at          |
      | google | google.com | not_caitlin | 2011-01-01 10:12:23 |
      And I am logged in as "caitlin"
      And I am an admin
    When I am on the homepage
    Then I should see "edit" within ".story .actions"
      And I should see "delete" within ".story .actions"