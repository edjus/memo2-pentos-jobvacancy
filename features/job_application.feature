Feature: Job Application
  In order to get a job
  As a candidate
  I want to apply to an offer

  Background:
  	Given only a "Web Programmer" offer exists in the offers list

  Scenario: Apply to job offer
    Given I access the offers list page
    When I apply
    Then I should receive a mail with offerer info

  Scenario: Apply to job offer with curriculum
    Given I access the offers list page
    When I apply with curriculum "linkedin.com/applicant.profile"
    Then I should receive a mail with offerer info
    And It should include "Curriculum: linkedin.com/applicant.profile"

  Scenario: Apply to job offer without curriculum
    Given I access the offers list page
    When I apply with no curriculum
    Then I should receive a mail with offerer info
    And It should include "Curriculum: not specified"

  Scenario: Expected remuneration when applying
    Given I access the offers list page
    When I apply with remuneration between 30000 and 60000
    Then the offeror receives an mail which includes "Expected remuneration: between 30000 and 60000"
    And I should receive a mail with offerer info
    And It should include "Expected remuneration: between 30000 and 60000"

  Scenario: Expected remuneration when applying
    Given I access the offers list page
    When I apply with remuneration between 30000 and 60000
    Then the offeror receives an mail which includes "Expected remuneration: between 30000 and 60000"
    And I should receive a mail with offerer info
    And It should include "Expected remuneration: between 30000 and 60000"	

  Scenario: Inital value of the remuneration range is negative
    Given I access the offers list page
    When I apply with remuneration between -60000 and 60000
    Then I am still in offer list page
    And I should see "Invalid Range"

  Scenario: Both values of the remuneration range are negative
    Given I access the offers list page
    When I apply with remuneration between -30000 and -10000
    Then I am still in offer list page
    And I should see "Invalid Range"

  Scenario: End value of the remuneration range is negative
      Given I access the offers list page
      When I apply with remuneration between 30000 and -10000
      Then I am still in offer list page
      And I should see "Invalid Range"


