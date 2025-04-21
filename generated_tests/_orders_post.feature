Feature: Create a new order

Background:
* url 'https://api.example.com/v1'
* header Accept = 'application/json'

Scenario: Successful request
    Given path '/orders'
    And headers { 
        "Content-Type": "application/json"
    }
    And param userId = 'user_123'
    And request {
      "userId": "user_123",
      "items": [
        {"productId": "prod_456", "quantity": 2, "attributes": {"color": "blue", "size": "medium"}}
      ]
    }
    When method post
    Then status 201
    And match response.id == 'order_789'
    And match response.userId == 'user_123'
    And match response.items[0].productId == 'prod_456'
    And match response.status == 'pending'

Scenario: Error case - Invalid input
    Given path '/orders'
    And headers { 
        "Content-Type": "application/json"
    }
    And param userId = 'wrong_user_id'
    And request {
      "userId": "wrong_user_id",
      "items": [
        {"productId": "prod_456", "quantity": 2, "attributes": {"color": "blue", "size": "medium"}}
      ]
    }
    When method post
    Then status 400
    And match response.code == 'INVALID_INPUT'