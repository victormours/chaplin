Feature: Basic auth

  Scenario: Using basic http auth for a remote api
    Given I have the following chaplin_config.json file
    """
    {
      "api_url": "http://localhost:1234",
      "basic_auth": {
        "user": "bob",
        "password": "some_secret"
      }
    }
    """

