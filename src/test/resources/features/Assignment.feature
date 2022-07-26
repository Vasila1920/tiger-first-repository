# 2)Test API endpoint "/api/accounts/add-primary-account" to add new Account with Existing email address.
# Then status code should be 400 – Bad Request ,  validate response
# 3)Test API endpoint "/api/accounts/add-account-car" to add car to existing account.
# Then status code should be 201 – Create ,  validate response
# 4)Test API endpoint "/api/accounts/add-account-phone" to add Phone number to existing account.
# Then status code should be 201 – Create ,  validate response
# 5)Test API endpoint "/api/accounts/add-account-address" to add address to existing account.
# Then status code should be 201 – Create ,  validate response
Feature: Add new Account

   # 1)Test API endpoint "/api/accounts/add-primary-account" to add new Account with Existing email address.
   # Then status code should be 400 – Bad Request ,  validate response
  Background: generate token for all scenarios.
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    * def generatedToken = response.token

  Scenario: Add new Account with Existing email address.
    Given path "/api/accounts/add-primary-account"
    And request {"email": "AngieKessler@gmail.com","title": "Mr.","firstName": "John","lastName": "Smith","gender": "MALE","maritalStatus": "MARRIED","employmentStatus": "Student", "dateOfBirth": "1990-01-10"}
    And header Authorization = "Bearer " + generatedToken
    When method post
    Then print response
    Then status 400
    * def errorMessage = response.errorMessage
    And assert errorMessage == "Account with Email AngieKessler@gmail.com is exist"

  # 2)Test API endpoint "/api/accounts/add-account-car" to add car to existing account.
  # Then status code should be 201 – Create ,  validate response
  Scenario: Add car to an existing Account.
    Given path "/api/accounts/add-account-car"
    And param primaryPersonId = 77
    And request {"id": 0,"primaryPerson": {"id": 77,"email": "AngieKessler@gmail.com","title": "Ms.","firstName": "Niz","lastName": "Noz","gender": "OTHER","maritalStatus": "SINGLE","employmentStatus": "Student","dateOfBirth": "11/28/2020"},"make": "lamborghini","model": "Lexus","year": "2020","licensePlate":"VA1920"}
    * def generatedToken = response.token
    And header Authorization = "Bearer " + generatedToken
    When method post
    Then print response
    And assert response.primaryPerson.email == "AngieKessler@gmail.com"
    Then status 201
 
  # 3)Test API endpoint "/api/accounts/add-account-phone" to add Phone number to existing account.
  # Then status code should be 201 – Create ,  validate response
  Scenario: Add Phone number to existing account.
    Given path "/api/accounts/add-account-phone"
    And param primaryPersonId = 77
    And request {"id": 77, "phoneNumber": "375-00-11890","phoneExtension": "+992","phoneTime": "Morning","phoneType": "Mobile"} 
    * def generatedToken = response.token
    And header Authorization = "Bearer " + generatedToken
    When method post
    Then print response
    Then status 201

    
   # 4)Test API endpoint "/api/accounts/add-account-address" to add address to existing account.
   # Then status code should be 201 – Create ,  validate response
  Scenario: Add address to existing account
     Given path "/api/accounts/add-account-address"
     And param primaryPersonId = 77
     And request {"id": 77,"addressType": "Home","addressLine1": "2878 Washington St.","city": "Arlington","state": "VA","postalCode": "33698","countryCode": "+1", "current": true}
     * def generatedToken = "Bearer " + generatedToken
     And header Authorization = "Bearer " + generatedToken
     When method post
     Then print response
     Then status 201
   
   
    
    
    
    
    
    
