Feature: Test CRUD methods in "Simple REST API" (the name of my API - consisting of user, book, and subject models)

Scenario: Fetch all users
    Given the service is running
    When I send GET HTTP request
    Then I receive valid HTTP response code 200  
    And I get a list of all users

Scenario: Create a new user
    Given the service is running
    When I send POST HTTP request
    Then I receive valid HTTP response code 200  
    And I get info on that specific user

# Scenario: Update a user
#     Given the service is running
#     When I send PATCH HTTP request
#     Then I receive valid HTTP response code 200  
#     And I get the info on the updated user

# Scenario: Delete a user
#     Given the service is running
#     When I send DELETE HTTP request
#     And I send GET HTTP request
#     Then I receive valid HTTP response code 404     
