Feature: Request headers

  Scenario: Setting headers for all requests to an API
    Given I have the following templates/header_echo.html file
    """
    The content-type you're requesting to the distant API is {{headers.requested_content_type}}.
    """
    And I have the following routes.json file
    """
    {
      "routes": [
      ["GET", "/header", "header_echo.html", { "headers":  ["GET", "/headers"]}]
      ]
    }
    """
    And I have the following chaplin_config.json file
    """
    {
      "api_url": "http://localhost:8080",
      "headers": { "Content-Type": "application/json" }
    }
    """
    Given I have the following API running
    """
    get "/headers" do
      if request.env["CONTENT_TYPE"]
        { requested_content_type: request.env["CONTENT_TYPE"] }.to_json
      else
        { requested_content_type: "unspecified" }.to_json
      end
    end
    """
    And I start a Chaplin server
    When I send the request GET /header
    Then I should get the following response
    """
    The content-type you're requesting to the distant API is application/json.
    """



