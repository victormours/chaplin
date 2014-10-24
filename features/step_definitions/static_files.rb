require 'childprocess'


Given(/^My project has a hello.txt file in the public directory$/) do
  `mkdir tmp/public`
  `echo "Hello Chaplin!" > tmp/public/hello.txt`
end

Given(/^I start a Chaplin server$/) do
  @process = ChildProcess.build("./bin/chaplin", "/tmp")
  # @process.io.inherit!
  @process.start
  sleep 1
end

When(/^I send the request GET \/hello\.txt$/) do
  @response = `curl -s http://localhost:8081/hello.txt`
end

Then(/^I should get the file as a response$/) do
  expect(@response).to eq "Hello Chaplin!"
end
