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
