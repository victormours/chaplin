Feature: Dynamic routes
  Routes can be defined with parameters, which can be used in the templates.

  Scenario: Using request parameters from a route
    Given I have the following templates/name.html file
    """
    My name is {{params.firstname}}.
    """
    And I have the following routes.json file
    """
    {
      "routes": {
        "GET /name/:firstname": "name.html"
      }
    }
    """
    And I start a Chaplin server
    When I send the request GET /name/Bob
    Then I should get the following response
    """
    My name is Bob.
    """
