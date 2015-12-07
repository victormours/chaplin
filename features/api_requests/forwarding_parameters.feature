Feature:  Parameters for api requests
  Chaplin can forward a request's parameters to the decorated API.

  Background:
    Given I have the following API running
    """
    get "/search" do
      case params["title"]

      when "City Lights"
        { title: "City Lights", year: 1931 }.to_json

      when "Modern Times"
        { title: "Modern Times", year: 1936 }.to_json

      end
    end
    """
    And I have the following templates/movie.html file
    """
    {{#movie}}The movie {{title}} came out in {{year}}.{{/movie}}
    """

  Scenario: Forwarding static parameters
    Given I have the following app.json file
    """
    {
      "routes": {
        "GET /city_lights": "movie.html"
      },

      "pages": {
        "movie.html": { "movie": ["GET /search", {"title": "City Lights"}] }
      }
    }
    """
    And I start a Chaplin server
    When I send the request GET /city_lights
    Then I should get the following response
    """
    The movie City Lights came out in 1931.
    """

  Scenario: Using dynamic parameters
    And I have the following app.json file
    """
    {
      "routes": {
        "GET /search": "movie.html"
      },

      "pages": {
        "movie.html": { "movie": ["GET /search", {"title": "{{ title }}"}] }
      }
    }
    """
    And I start a Chaplin server
    When I send the request GET /search?title=City%20Lights
    Then I should get the following response
    """
    The movie City Lights came out in 1931.
    """

