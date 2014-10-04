require 'spec_helper'

RSpec.configure do |config|
  config.before(:suite) do
    @api_pid = fork do
      fake_api = Rack::File.new('spec/fixtures/fake_api')
      Rack::Server.start(app: fake_api, Port: 8080)
    end
    @chaplin_pid = fork do
      Dir.chdir("spec/fixtures/fake_chaplin_project")
      chaplin_server = Chaplin::Server.new('localhost:8080')

      Rack::Server.start(app: chaplin_server, Port: 8081)
    end
    sleep 3 #give the server time to boot
  end

  config.after(:suite) do
    Process.kill("INT", @chaplin_pid)
    Process.kill("INT", @api_pid)
  end
end
