require "rack"

Given(/^I have the following (.*\/)?(.*) file$/) do |directory, filename, content|
  `mkdir -p tmp/chaplin_project/#{directory}`
  `echo #{content.inspect} > tmp/chaplin_project/#{directory}/#{filename}`
end

Given(/^I have an api running that responds to GET (.*) with the following JSON$/) do |path, json_data|
  steps %Q{
    Given I have an api running on port 8080 that responds to GET /user with the following JSON
  }
end

Given(/^I have an api running on port (\d+) that responds to GET (.*) with the following JSON$/) do |port_number, path, json_data|
  `mkdir -p tmp/api`
  `echo #{json_data.inspect} > tmp/api/#{path}`
  api_server = Rack::File.new("tmp/api/")
  @api_pid = fork { Rack::Server.start(app: api_server, Port: port_number) }
  sleep 1
end

