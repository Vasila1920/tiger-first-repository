
Feature: Create an account and add address to the account.

  # Step 1) Get token
  # Step 2) Generate an account
  # Step 3) add address to generated account
  Background: Create new account
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def createAccountResult = callonce read('CreateAccount.feature')
    And print createAccountResult
    * def primaryPersonId = createAccountResult.response.id
    * def token = createAccountResult.result.response.token

  Scenario: Add address to an account
    Given path '/api/accounts/add-account-address'
    And param primaryPersonId = primaryPersonId
    And header Authorization = "Bearer " + token
    Given request
      """
      {
      "id": 0,
      "addressType": "Home",
      "addressLine1": "1258 Arlingot Blvd",
      "city": "Arlington",
      "state": "Virginia",
      "postalCode": "36988",
      "countryCode": "25689",
      "current": true
      }
      """
    When method post
    Then status 201
    And print response
