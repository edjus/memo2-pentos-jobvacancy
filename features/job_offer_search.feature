Feature: Job Offer Search

  Background:
    Given "Java dev" offer exists
    And "Ruby dev" offer exists

  Scenario: Search offer
    Given I access the offers list page
    And I fill the search bar with "Java"
    When I click search
    Then I should see "Java dev"
    And I should not see "Ruby dev"
