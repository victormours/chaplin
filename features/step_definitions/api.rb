require 'childprocess'

Given(/^I have the following API running$/) do |sinatra_api_code|
  `echo "require 'json'" > tmp/api.rb`
  `echo "require 'sinatra'" >> tmp/api.rb`
  `echo "set :port, 8080" >> tmp/api.rb`
  `echo #{sinatra_api_code.inspect} >> tmp/api.rb`
  @api_server = ChildProcess.build("bundle", "exec", "ruby", "tmp/api.rb")
  # Uncomment the following line to see the server's output
  # @api_server.io.inherit!
  @api_server.start
  sleep 3
end


