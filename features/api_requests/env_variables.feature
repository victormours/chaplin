Feature: Environment variables
  Environment variables can be used in the app.yml file to define request parameters. This is useful for setting api keys for example.

  Scenario: Using an env variable as a request param
    Given I have the following app.yml file
    """
    routes:
      GET /: index.html

    pages:
      index.html:
        user:
          - GET /me
          -
            auth: "{{ env.API_KEY }}"
    """
    And I set the environment variable API_KEY to 123
    And I have the following API running
    """
    get "/me" do
      if params[:auth] == '123'
        { name: "Charlie" }.to_json
      else
        {}
      end
    end
    """
    And I have the following templates/index.html file
    """
    Hello {{ user.name }}.
    """
    And I start a Chaplin server
    When I send the request GET /
    Then I should get the following response
    """
    Hello Charlie.
    """
