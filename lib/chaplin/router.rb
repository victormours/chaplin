class Chaplin
  class Router

    def initialize(routes_filename)
      @routes_filename = routes_filename
      @routes = []
    end

    def load_routes
      puts "Found routes"
      puts routes_json
    end

    def routes
    end

    private

    def routes_json
      @routes_json = @json_data['routes']
    end

    def json_data
      @json_data ||= JSON.load(File.open(@routes_filename))
    end

  end
end
