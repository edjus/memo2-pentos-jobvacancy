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
    Then the offeror receives an mail which includes "Expected remuneration: between ARS$30000 and ARS$60000"
    And I should receive a mail with offerer info
    And It should include "Expected remuneration: between ARS$30000 and ARS$60000"	

  Scenario: Inital value of the remuneration range is negative
    Given I access the offers list page
    When I apply with remuneration between -60000 and 60000
    Then I am still in the apply page
    And I should see "Invalid Range"

  Scenario: Both values of the remuneration range are negative
    Given I access the offers list page
    When I apply with remuneration between -30000 and -10000
    Then I am still in the apply page
    And I should see "Invalid Range"

  Scenario: End value of the remuneration range is negative
    Given I access the offers list page
    When I apply with remuneration between 30000 and -10000
    Then I am still in the apply page
    And I should see "Invalid Range"

  Scenario: Inital value is grater than end value
    Given I access the offers list page
    When I apply with remuneration between 60000 and 30000
    Then I am still in the apply page
    And I should see "Invalid Range"

  Scenario: Specific expected remuneration when applying
    Given I access the offers list page
    When I apply with remuneration between 30000 and 30000
    Then the offeror receives an mail which includes "Expected remuneration: ARS$30000"
    And I should receive a mail with offerer info
    And It should include "Expected remuneration: ARS$30000"	
  
  Scenario: Minimum expected remuneration when applying
    Given I access the offers list page
    When I apply with remuneration between 30000 and 0
    Then the offeror receives an mail which includes "Expected remuneration: starting from ARS$30000"
    And I should receive a mail with offerer info
    And It should include "Expected remuneration: starting from ARS$30000"

  Scenario: Maximum expected remuneration when applying
    Given I access the offers list page
    When I apply with remuneration between 0 and 60000
    Then the offeror receives an mail which includes "Expected remuneration: up to ARS$60000"
    And I should receive a mail with offerer info
    And It should include "Expected remuneration: up to ARS$60000"

  Scenario: apply to job offer with valid bio
    Given I access the offers list page
    When I apply with bio "This is a short bio about me! I like cooking, golf and dogs. My favorite color is #c0ffee"
    Then I should receive a mail with offerer info
    And It should include "Bio: This is a short bio about me! I like cooking, golf and dogs. My favorite color is #c0ffee"

  Scenario: apply to job offer with no bio
    Given I access the offers list page
    When I apply with no bio
    Then I should receive a mail with offerer info
    And It should include "Bio: not specified"

  Scenario: apply to job offer with a bio over 500 character
    Given I access the offers list page
    When I apply with bio "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc at porta urna. Mauris dignissim felis non neque vestibulum, a viverra orci feugiat. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nullam viverra diam dui, et lacinia elit bibendum ut. Quisque id facilisis risus. Morbi et magna venenatis, aliquet magna sed, elementum ante. Phasellus orci nisl, mattis vitae arcu vel, cursus eleifend leo. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc at porta urna. Mauris dignissim felis non neque vestibulum, a viverra orci feugiat. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nullam viverra diam dui, et lacinia elit bibendum ut. Quisque id facilisis risus. Morbi et magna venenatis, aliquet magna sed, elementum ante. Phasellus orci nisl, mattis vitae arcu vel, cursus eleifend leo."
    Then I am still in the apply page
    And I should see "Bio too long. Max 500 characters"

  @wip
  Scenario: Apply to job offer with email with no domain
    Given I access the offers list page
    When I apply with email "an.invalid.email"
    Then I am still in offer list page
    And I should see "Invalid email"