Feature: Sessions

  HTTP session (cookies) between the client and the Chaplin server can be modified during redirects.

  Scenario: Logging in and out
    Given I have the following app.yml file
    """
    routes:

      GET /: index.html
      GET /login: redirect login
      GET /logout: redirect logout


    redirects:

      login:
        path: "/"
        cookies:
          username: '{{login.username}}'
        requests:
          login: GET login

      logout:
        path: '/'
        delete_cookies:
          - username
        requests: {}
    """
    And I have the following templates/index.html file
    """
    {{#session.username}}
    Your name is {{session.username}}.
    {{/session.username}}
    {{^session.username}}
    Please log in
    {{/session.username}}
    """
    And I have the following API running
    """
    get "/login" do
      { username: "Bob"}.to_json
    end
    """
    And I start a Chaplin server
    When I send the request GET /login
    When I send the request GET /
    Then I should get the following response
    """
    Your name is Bob.
    """

    When I send the request GET /logout
    When I send the request GET /
    Then I should get the following response
    """
    Please log in
    """
