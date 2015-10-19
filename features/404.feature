Feature: Page not found (404)
  In order to specify which page should be rendered when a route can't be resolved, a 404 can be defined in the app.yml file.

  Scenario: Defining a 404 page
    Given I have the following app.yml file
    """
    layout: layout.html
    404: not_found.html
    routes: {}
    """
    And I have the following templates/not_found.html file
    """
    Page not found
    """
    And I have the following templates/layout.html file
    """
    Page layout
    {{{content}}}
    """
    And I start a Chaplin server
    When I send the request GET /something
    Then I should get the following response
    """
    Page layout
    Page not found

    """

