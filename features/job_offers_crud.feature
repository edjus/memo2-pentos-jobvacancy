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

  Scenario: Job applications quantity with none applicants
    Given I have an job offer titled "Programador Java", on "Buenos Aires" with description "Full-stack Java Dev"
    When I access "My Offers"
    Then the offer "Programador Java" has 0 applications

  Scenario: Job applications quantity with two applicants
    Given I have an job offer titled "Programador Java Junior", on "Buenos Aires" with description "Full-stack Java Dev"
    And job applicant named "Juan Medina" applied for "Programador Java Junior"
    And job applicant named "John Doe" applied for "Programador Java Junior"
    When I access "My Offers"
    Then the offer "Programador Java Junior" has 2 applications

  Scenario: Create from existing
    Given an offer with title "Java dev", location "Buenos Aires" and description "Full stack Java dev" exists
    And I access the my offers page
    When I click copy for "Java dev"
    Then I should be on the copy offer page
    And the title field value should be "Java dev"
    And the location field value should be "Buenos Aires"
    And the description field value should be "Full stack Java dev"

  Scenario: Create from existing and confirm copied offer
    Given an offer with title "Java dev", location "Buenos Aires" and description "Full stack Java dev" exists
    And I access the my offers page
    And I click copy for "Java dev"
    And I set title to "Java dev Sr"
    When confirm the new offer
    Then I should see "Offer created"
    And I should see "Java dev" in My Offers
    And I should see "Java dev Sr" in My Offers
    And the offer "Java dev Sr" should have "Buenos Aires"
    And the offer "Java dev Sr" should have "Full stack Java dev"
