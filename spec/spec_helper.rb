RSpec.configure do |config|
  Kernel.srand config.seed

  config.before(:suite) do
    @chaplin_pid = fork do
      Dir.chdir("spec/fake_chaplin_project")
      chaplin_server = Chaplin::Server.new('pace-api.herokuapp.com')

      Rack::Server.start(app: chaplin_server, Port: 8081)
    end
    sleep 3 #give the server time to boot
  end

  config.after(:suite) do
    Process.kill("INT", @chaplin_pid)
  end
end
