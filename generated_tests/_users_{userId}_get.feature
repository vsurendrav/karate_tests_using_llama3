Feature: Get user details by ID

Background:
* url 'https://api.example.com/v1'
* headers { Accept: 'application/json' }

Scenario: Successful GET request
Given path '/users/user_123'
When method get
Then status 200
And match response == read('classpath:schemas/UserResponse.json')
And match response.id == 'user_123'

Scenario: Error - User not found (404)
Given path '/users/invalid_user_id'
When method get
Then status 404
And match response.code == 'NOT_FOUND'
And match response.message == 'User not found'