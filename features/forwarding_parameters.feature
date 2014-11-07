Feature: Forwarding request parameters
  Chaplin can forward a request's parameters to the decorated API.

  Scenario: Forwarding parameters for a GET request
    Given I have the following API running
    """
    get "/search" do
      { title: "City Lights", year: 1931 }.to_json if params == {"title" => "City Lights"}
    end
    """
    And I have the following templates/search_result.html file
    """
    {{#result}}The movie {{title}} came out in {{year}}.{{/result}}
    """
    And I have the following routes.json file
    """
    {
      "routes": [
        ["GET", "/search", "search_result.html", { "result": ["GET", "/search", "forward_params"] }]
      ]
    }
    """
    And I start a Chaplin server
    When I send the request GET /search?title=City%20Lights
    Then I should get the following response
    """
    The movie City Lights came out in 1931.
    """
