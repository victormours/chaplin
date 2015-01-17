Feature: Redirection

  The redirection path can use the data from the api requests.

  Scenario: Redirection
    Given I have the following routes.json file
    """
    routes:

      POST /articles: redirect create_article

    redirects:
      create_article:
        path: "/article/{{article.objectId}}"
        requests:
          article:
            - "POST classes/article"
            -
              body: "{{body}}"
            - 'Content-Type': 'application/json'

    """
    Then sending a POST request to /create redirects me to the create article's page

