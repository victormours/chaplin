Then(/^Chaplin connects to the api on port (\d+)$/) do |port_number|
  steps %Q{
  Given I have the following templates/user_info.html file
  """
    {{#user_data}}Your name is {{name}}{{/user_data}}
  """
  And I have the following routes.json file
  """
    {
  "routes": [
        ["GET", "/profile", "user_info.html", { "user_data": ["GET", "/user"]  }]
      ]
    }
  """
  And I have an api running on port #{port_number} that responds to GET /user with the following JSON
  """
  {"name": "Bob"}
  """
  And I start a Chaplin server
  When I send the request GET /profile
  Then I should get the following response
  """
    Your name is Bob
  """
  }
end
