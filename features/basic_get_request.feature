Feature: Basic templating
  Chaplin sends a request to an API and fills a template.

  Scenario: Sending a request for a templated file
    Given I have the following templates/user_info.html file
    """
    Your name is {{name}}
    """
    And I have the following routes.json file
    """
    {
      "routes": [
        ["GET", "/profile", "user_info.html", { "user_data": ["GET", "/user"]  }]
      ]
    }
    """
    And I have an api running that responds to GET /user with the following JSON
    """
    {"name": "Bob"}
    """
    And I start a Chaplin server
    When I send the request GET /profile
    Then I should get the following response
    """
    Your name is Bob
    """
