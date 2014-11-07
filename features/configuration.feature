Feature: Configuration
  Chaplin reads its configuration from a chaplin_config.json file at the root of you chaplin project.

  Scenario: Pointing to a remote API
    Given I have the following chaplin_config.json file
    """
    {
      "api_url": "http://localhost:1234"
    }
    """
    Then Chaplin connects to the api on port 1234


