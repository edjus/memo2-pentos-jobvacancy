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

  Scenario: View job offer’s applications when there are no applications
    Given "Java dev" offer exists
    And I access the my offers page
    When I click on view the offer applications
    Then I should be on the offer's applications page
    And the table should be empty

  Scenario: View job offer’s applications when there are applications
    Given "Java dev" offer exists
    And the user "rob@mail.com" has applied to the offer "Java dev" with curriculum "linkedin.com/rob.profile", remuneration 30000 and bio "My name is Rob"
    And the user "john@mail.com" has applied to the offer "Java dev" with curriculum "linkedin.com/john.profile", remuneration between 30000 and 40000 and bio "My name is John"
    And I access the my offers page
    When I click on view the offer applications
    Then I should see a record with email "rob@mail.com", curriculum "linkedin.com/rob.profile", remuneration "ARS$30000" and bio "My name is Rob"
    And I should see a record with email "john@mail.com", curriculum "linkedin.com/john.profile", remuneration "between ARS$30000 and ARS$40000" and bio "My name is John"

  Scenario: Delete button is disabled when the offer has applications
   Given I have an job offer titled "Programador Java Junior", on "Buenos Aires" with description "Full-stack Java Dev"
   And job applicant named "Juan Medina" applied for "Programador Java Junior"
   When I access the my offers page
   Then the "Delete" button should be disabled
  
  Scenario: Satisfied offers do not show up in the available offers list
    Given "Java dev Sr" offer exists
    And "Java dev Jr" offer exists
    And I access the my offers page
    And I click satisfy for "Java dev Sr"
    When I access the offer list page
    Then I should see "Java dev Jr"
    And I should not see "Java dev Sr"
    And I should see Activate option for "Java dev Sr" in My Offers
