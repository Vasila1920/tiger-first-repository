Feature: Create Account

  # 1)Test API endpoint "/api/accounts/add-primary-account" to add new Account (Same as we do fill the form in UI).
  # Then status code should be 201– CREATED , with response generate account with Email address.
  Background: generate token for all scenarios.
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    * def generatedToken = response.token

  Scenario: Create new Account happy path
    Given path "/api/accounts/add-primary-account"
    And request {"email": "john.carr1@mail.com", "title": "Mr.","firstName": "Vasila","lastName": "Rakh","gender": "MALE","maritalStatus": "MARRIED","employmentStatus": "Software developer","dateOfBirth": "1988-07-05"}
    And header Authorization = "Bearer " + generatedToken
    When method post
    Then print response
    Then status 201
