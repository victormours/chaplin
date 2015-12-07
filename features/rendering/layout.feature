Feature: Embedding templates in layout
  Templates can be embedded in a layout specified in the app.json

  Scenario: Embedding a template in a layout
    Given I have the following app.json file
    """
    {
      "layout": "layout.html",

      "routes": {
        "GET /": "index.html"
      }
    }
    """
    And I have the following templates/layout.html file
    """
    This is the top of the layout.
    {{content}}
    This is the bottom of the layout.
    """
    And I have the following templates/index.html file
    """
    This is the index.
    """
    And I start a Chaplin server
    When I send the request GET /
    Then I should get the following response
    """
    This is the top of the layout.
    This is the index.

    This is the bottom of the layout.
    """
