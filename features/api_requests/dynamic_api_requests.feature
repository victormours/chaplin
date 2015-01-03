Feature: Dynamic api requests
  Params from the request can be used to define an api endpoint.

  Scenario: Using request parameters from a route
    Given I have the following templates/film.html file
    """
    {{film.title}} came out in {{film.year}}.
    """
    And I have the following routes.json file
    """
    {
      "routes": {
        "GET /film/:film_name": "film.html"
      },

      "pages": {
        "film.html": {"film": ["GET /films/{{film_name}}"]}
      }
    }
    """
    And I have the following API running
    """
    get "/films/city_lights" do
      { title: "City Lights", year: 1931 }.to_json
    end
    """
    And I start a Chaplin server
    When I send the request GET /film/city_lights
    Then I should get the following response
    """
    City Lights came out in 1931.
    """
