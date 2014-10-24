Feature: Serving static files
  Chaplin serves all static files in the public directory

  Scenario: Sending a request for a static file
    Given I have the following public/hello.txt file
    """
    Hello Chaplin!
    """
    And I have the following routes.json file
    """
    { \"routes\": [] }
    """
    And I start a Chaplin server
    When I send the request GET /hello.txt
    Then I should get the following response
    """
    Hello Chaplin!
    """
