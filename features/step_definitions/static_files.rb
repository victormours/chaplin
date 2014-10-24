Given(/^My project has a hello.txt file in the public directory$/) do
  `mkdir tmp/public`
  `echo "Hello Chaplin!" > tmp/public/hello.txt`
end

Given(/^I start a Chaplin server$/) do
  `./bin/chaplin /tmp &`
end

When(/^I send the request GET \/hello\.txt$/) do
end

Then(/^I should get the file as a response$/) do
  pending # express the regexp above with the code you wish you had
end
