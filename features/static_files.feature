Feature: Serving static files
  Chaplin serves all static files in the public directory

  Scenario: Sending a request for a css file
    Given My project has a main.css file in the public directory
    When I send the request GET /main.css
    Then I should get the file as a response
