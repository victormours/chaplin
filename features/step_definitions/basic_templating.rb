require "rack"

Given(/^I have the following (.*\/)?(.*) file$/) do |directory, filename, content|
  `mkdir -p tmp/chaplin_project/#{directory}`
  `echo #{content.inspect} > tmp/chaplin_project/#{directory}/#{filename}`
end

Given(/^I have an api running that responds to GET (.*) with the following JSON$/) do |path, json_data|
  `mkdir -p tmp/api`
  `echo #{json_data.inspect} > tmp/api/#{path}`
  api_server = Rack::File.new("tmp/api/")
  @api_pid = fork { Rack::Server.start(app: api_server, Port: 8080) }
  sleep 1
end

