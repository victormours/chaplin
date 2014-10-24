Feature: Basic templating
  Chaplin sends a request to an API and fills a template.

  Scenario: Sending a request for a templated file
    Given My project has a user_info.html file in the templates directory
    And I have the following routes.json file
    """
    {
      "routes": [
        ["GET", "/profile", "user_info.html", { "user_data": ["GET", "/user"]  }]
      ]
    }
    """
    And I have an api running that responds to GET /user
    And I start a Chaplin server
    When I send the request GET /profile
    Then I should get the user profile with the data from the api as a response
