require 'rack/test'
include Rack::Test::Methods

require 'chaplin'

def app
  @app
end

Given(/^I start a Chaplin server$/) do
  @app = Chaplin.new("tmp/chaplin_project").server
end


When(/^I send the request GET (.*)$/) do |path|
  get path
end

Then(/^I should get the following response$/) do |expected_response|
  expect(last_response.body).to eq expected_response + "\n"
end

