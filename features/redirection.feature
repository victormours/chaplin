Feature: Redirection

  Scenario: Redirection
    Given I have the following routes.json file
    """
    {
      "routes": {
        "POST /create", "redirect /", { "new_article":  ["POST", "/create_article", {"article": "{{article}}"]}]
        },

        "redirections": {}
    }
    """
    Then sending a POST request to /create redirects me to /

