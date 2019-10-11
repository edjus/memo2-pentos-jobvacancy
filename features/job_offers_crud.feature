Feature: Job Offers CRUD
  In order to get employees
  As a job offerer
  I want to manage my offers

  Background:
  	Given I am logged in as job offerer

  Scenario: Create new offer
    Given I access the new offer page
    When I fill the title with "Programmer vacancy"
		And confirm the new offer    
    Then I should see "Offer created"
    And I should see "Programmer vacancy" in My Offers

  Scenario: Update offer
    Given I have "Programmer vacancy" offer in My Offers
    And I edit it
    And I set title to "Programmer vacancy!!!"
    And I save the modification
    Then I should see "Offer updated"
    And I should see "Programmer vacancy!!!" in My Offers

  Scenario: Delete offer
    Given I have "Programmer vacancy" offer in My Offers
    Given I delete it
    Then I should see "Offer deleted"
    And I should not see "Programmer vacancy!!!" in My Offers

  @wip
  Scenario: Create from existing
    Given an offer with title "Java dev", location "Buenos Aires" and description "Full stack Java dev" exists
    And I access the new offer page
    When I click copy for "Java dev"
    Then I should be on the New Offer page
    And the title field should contain "Java dev"
    And the location field should contain "Buenos Aires"
    And the description field should contain "Full stack Java dev"
