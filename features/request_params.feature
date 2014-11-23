Feature: Using request parameters in templates
  Chaplin can use the request's parameters in the templates.

  Scenario: Using request parameters
    Given I have the following templates/name.html file
    """
    My name is {{params.firstname}}.
    """
    And I have the following routes.json file
    """
    {
      "routes": {
        "GET /name": "name.html"
      }
    }
    """
    And I start a Chaplin server
    When I send the request GET /name?firstname=Bob
    Then I should get the following response
    """
    My name is Bob.
    """
