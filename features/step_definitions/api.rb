Given(/^I have the following API running$/) do |sinatra_api_code|
  `echo "require 'json'" > tmp/api.rb`
  `echo "require 'sinatra'" >> tmp/api.rb`
  `echo "set :port, 8080" >> tmp/api.rb`
  `echo #{sinatra_api_code.inspect} >> tmp/api.rb`
  @api_server = ChildProcess.build("bundle", "exec", "ruby", "tmp/api.rb")
  @api_server.start
  sleep 1
end


