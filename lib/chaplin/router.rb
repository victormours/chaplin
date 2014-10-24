require 'json'
require_relative 'models'
require_relative 'page'

class Chaplin

  class Router

    def initialize(routes_filename)
      @routes_filename = routes_filename
      @routes = []
    end

    attr_accessor :routes

    def load_routes
      routes_json.each do |route|
        add_route(route)
      end
    end

    private

    def add_route(route)
      endpoint = Endpoint.new(route[0].downcase.to_sym, route[1])
      page = Page.new(route[2], route[3])
      @routes << Route.new(endpoint, page)
    end

    def routes_json
      @routes_json = json_data['routes']
    end

    def json_data
      @json_data ||= JSON.load(File.open(@routes_filename))
    end

  end
end
