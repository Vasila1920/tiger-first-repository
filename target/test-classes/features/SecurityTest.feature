@Smoke @Regression
Feature: Security test. Token Genaration test
@Regression
Scenario: generate token with valid username and password.
Given url "https://tek-insurance-api.azurewebsites.net"
And path "/api/token"
And request {"username": "supervisor", "password": "tek_supervisor"}
When method post
Then status 200
And print response


@Regression
Scenario: generate token with Invalid Username and valid password
   Given url "https://tek-insurance-api.azurewebsites.net"
   And path "/api/token"
   And request {"username": "invadil_user", "password": "tek_supervisor"}
   When method post
   Then status 404
   And print response
   * def errorMessage = response.errorMessage
   And assert errorMessage == "USER_NOT_FOUND"
@Regression
Scenario: generate token with valid Username and invalid password
   Given url "https://tek-insurance-api.azurewebsites.net"
   And path "/api/token"
   And request {"username": "supervisor", "password": "invalid_password"}
   When method post
   Then status 400
   And print response
   * def errorMessage = response.errorMessage
   And assert errorMessage == "Password Not Matched"













