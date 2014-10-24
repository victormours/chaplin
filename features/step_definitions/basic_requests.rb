require 'childprocess'

Given(/^I start a Chaplin server$/) do
  @chaplin_server = ChildProcess.build("bundle", "exec", "./bin/chaplin", "tmp/chaplin_project")
  @chaplin_server.io.inherit!
  @chaplin_server.start
  sleep 1
end


When(/^I send the request GET (.*)$/) do |path|
  @response = `curl -s http://localhost:8081/#{path}`
end

Then(/^I should get the following response$/) do |expected_response|
  expect(@response).to eq expected_response + "\n"
end

