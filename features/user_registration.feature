Feature: User registration

  Scenario: Valid registration
    Given I am at Registration page 
    And I fill the name with "Rob"
    And I fill the email with "rob@mail.com"
    And I fill the password with "pentos"
    And I fill the password confirmation with "pentos"
    When I confirm the registration
    Then I am redirected to home page
    And I should see "User created"