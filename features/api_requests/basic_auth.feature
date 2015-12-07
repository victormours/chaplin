Feature: Basic auth

  Scenario: Using basic http auth for a remote api
    Given I have the following app.yml file
    """
    api_url: "http://localhost:1234"
    api_basic_auth:
      user: "bob"
      password: "some_secret"
    """

