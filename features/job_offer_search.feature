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

  Scenario: Clear search
    Given I access the offers list page
    And I fill the search bar with "Java"
    And I click search
    When I click clear
    Then I should see "Java dev"
    And I should see "Ruby dev"

  @wip
  Scenario: Satisfied offers do not show up in searches
	  Given "Java dev Sr" offer exists
	  And "Java dev Jr" offer exists
    And the "Java dev Sr" offer is satisfied
    And I access the offer list page
    And I fill the search bar with "Java"
	  When I click search
	  Then I should see "Java dev Jr"
	  And I should not see "Java dev Sr”