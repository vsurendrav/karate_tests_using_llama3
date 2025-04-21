Feature: Create a new user

Background:
* url 'https://api.example.com/v1'
* header Content-Type = 'application/json'

Scenario: Successful create
    Given path '/users'
    And param userId = 'user_123'  # assuming a valid user ID
    * def requestBody =
      """
      {
        "name": "John Doe",
        "email": "john.doe@example.com",
        "preferences": {"theme": "dark", "notifications": "enabled"},
        "addresses": [
          {"street": "123 Main St", "city": "Springfield", "country": "USA", "zipCode": "62701"}
        ]
      }
      """
    When method post
    Then status 201
    And match response == { id: '#string', name: 'John Doe', email: 'john.doe@example.com', preferences: { theme: 'dark', notifications: 'enabled' }, addresses: ['#array'], createdAt: '#string' }

Scenario: Error - invalid input
    Given path '/users'
    When method post
    Then status 400
    And match response == { code: '#string', message: '#string', details: '#array' }