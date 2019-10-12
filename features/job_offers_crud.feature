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

