# 1) Generate a valid token and verify it with below requirement.
# test api endpoint "/api/token/verify" with valid token.
# Status should be 200 – bad request and response is true.

Feature: Security test. Verify Token test.

Scenario: Verify valid token
  Given url "https://tek-insurance-api.azurewebsites.net"
  And path "/api/token"
  And request {"username": "supervisor", "password": "tek_supervisor"}
  When method post
  Then status 200
  * def generatedToken = response.token
  Given path "/api/token/verify"
  And param username = "supervisor"
  And param token = generatedToken
  When method get
  Then status 200
  And print response
  
Scenario: Verify invalid token
 Given url "https://tek-insurance-api.azurewebsites.net"
  Given path "/api/token/verify"
  And param username = "supervisor"
  And param token = "Wrong Token"
  When method get
  Then status 400
  And print response
  
# 3) test api endpoint "/api/token/verify" with valid token.
    # and invalid username, then status should be 400
    # and and errorMessage = Wrong Username send along with Token

Scenario: Test Token Verify with valid token and invalid username
Given url "https://tek-insurance-api.azurewebsites.net" 
And path "/api/token"
  And request {"username": "supervisor", "password": "tek_supervisor"}
  When method post
  Then status 200
  * def generatedToken = response.token
  Given path "/api/token/verify"
  And param username = "Inavalid Username"
  And param token = generatedToken
  When method get
  Then status 400
  And print response
  * def errorMessage = response.errorMessage
  And assert errorMessage == "Wrong Username send along with Token"




















