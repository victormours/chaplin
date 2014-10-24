require 'childprocess'

Given(/^I start a Chaplin server$/) do
  @process = ChildProcess.build("./bin/chaplin", "tmp/chaplin_project")
  @process.start
  sleep 1
end

When(/^I send the request GET (.*)$/) do |path|
  @response = `curl -s http://localhost:8081/#{path}`
end

Then(/^I should get the following response$/) do |expected_response|
  expect(@response).to eq expected_response + "\n"
end

