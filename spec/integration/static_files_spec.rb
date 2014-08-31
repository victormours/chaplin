require 'spec_helper'
require_relative '../../lib/chaplin'
require 'rack'

describe 'Serving static files' do

  before do
    @chaplin_pid = fork do
      Dir.chdir("spec/fake_chaplin_project")
      chaplin_server = Chaplin::Server.new('pace-api.herokuapp.com')

      Rack::Server.start(app: chaplin_server, Port: 8081)
    end
    sleep 3 #give the server time to boot
  end

  it "serves static files as is" do
    response = Net::HTTP.get(URI('http://localhost:8081/hello.txt'))
    expect(response).to eq "Hello Chaplin!\n"
  end

  after do
    Process.kill("INT", @chaplin_pid)
  end

end
