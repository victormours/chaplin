Feature: Rendering environment variables
  Environment variables can be used in templates. This is useful for setting Google Analytics ids for example.
  They have to be passed from the app.yml file. This way, all environment variables can be found in the same place.

  Scenario: Rendering an env variable in a template.
    Given I have the following templates/index.html file
    """
    {{app_id}}
    """
    And I set the environment variable APP_ID to 123
    And I have the following app.yml file
    """
    routes:
      GET /: index.html

    pages:
      index.html:
        app_id: "{{ env.APP_ID }}"
    """
    And I start a Chaplin server
    When I send the request GET /
    Then I should get the following response
    """
    123
    """

