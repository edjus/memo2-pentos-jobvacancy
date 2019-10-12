Feature: User registration

  Scenario: Valid registration
    Given I am at registration page 
    And I fill the name with "Rob"
    And I fill the email with "rob@mail.com"
    And I fill the password with "GoTPent0s!"
    And I fill the password confirmation with "GoTPent0s!"
    When I confirm the registration
    Then I am redirected to home page
    And I should see "User created"

  Scenario: Invalid registration, invalid size password
    Given I am at registration page 
    And I fill the name with "Rob"
    And I fill the email with "rob@mail.com"
    And I fill the password with "got"
    And I fill the password confirmation with "got"
    When I confirm the registration
    Then I am still in Registration page
    And I should see "Sorry, passwords must have at least 8 characters"
  
  Scenario: Invalid registration, password without an Upper Case character
    Given I am at registration page 
    And I fill the name with "Rob"
    And I fill the email with "rob@mail.com"
    And I fill the password with "qwertyui"
    And I fill the password confirmation with "qwertyui"
    When I confirm the registration
    Then I am still in Registration page
    And I should see "Sorry, passwords must have at least one Upper Case character"

  Scenario: Invalid registration, password without a special character
    Given I am at registration page 
    And I fill the name with "Rob"
    And I fill the email with "rob@mail.com"
    And I fill the password with "qwertyuiL"
    And I fill the password confirmation with "qwertyuiL"
    When I confirm the registration
    Then I am still in Registration page
    And I should see "Sorry, passwords must have at least one special character"

  @wip
  Scenario: Invalid registration, password without a number
    Given I am at registration page 
    And I fill the name with "Rob"
    And I fill the email with "rob@mail.com"
    And I fill the password with "qwertyuiL"
    And I fill the password confirmation with "qwert.yuiL"
    When I confirm the registration
    Then I am still in Registration page
    And I should see "Sorry, passwords must be alphanumeric"