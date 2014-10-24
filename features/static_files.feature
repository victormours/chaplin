Feature: Serving static files
  Chaplin serves all static files in the public directory

  Scenario: Sending a request for a css file
    Given My project has a public/hello.txt file with the following content
    """
    Hello Chaplin!
    """
    And I start a Chaplin server
    When I send the request GET /hello.txt
    Then I should get the following response
    """
    Hello Chaplin!
    """
