Feature: Configuration
  Chaplin reads its configuration from a chaplin_config.json file at the root of you chaplin project.
  For testing purposes, the examples given here point to localhost, but any url can be used

  Scenario: Using a YAML configuration
    Given I have the following app.yml file
    """
    api_url: http://localhost:1234

    routes:
      GET /profile: "user_info.html"

    pages:
      user_info.html:
        user_data: "GET /user"
    """
    Then Chaplin connects to the api on port 1234

  Scenario: Using a json configuration
    Given I have the following app.json file
    """
    {
      "routes": {
        "GET /profile": "user_info.html"
      },

      "pages": {
        "user_info.html":  { "user_data": ["GET /user"]  }
      },

      "api_url": "http://localhost:1234"
    }
    """
    Then Chaplin connects to the api on port 1234

