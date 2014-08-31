require 'json'

module Chaplin

  Route = Struct.new(:method, :path, :template, :data)

  class Router

    def initialize(routes_filename)
      @routes_filename = routes_filename
    end

    def template_for(request)
      route = route_for(request.request_method,
                         request.path)
      route.template
    end

    private

    def route_for(http_method, path)
      routes.find do |route|
        route.method == http_method &&
          route.path == path
      end
    end

    def routes
      @routes ||= build_routes
    end

    def build_routes
      routes_json = JSON.load(File.open(@routes_filename))['routes']
      routes_json.map do |route|
        method_and_path = route.first.split(' ')
        method = method_and_path.first
        path = method_and_path.last
        Route.new(method, path, route[1], route.last)
      end
    end

  end
end
