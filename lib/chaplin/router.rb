require 'json'

module Chaplin
  class Router

    def initialize(routes_filename)
      @routes_filename = routes_filename
    end

    def template_for(request)
      route = route(request)
      route && route.values.first
    end

    private

    def route(request)
      routes_for_method(request.request_method).find do |route|
        route.keys.first == request.path
      end
    end

    def routes_for_method(http_verb)
      routes.map do |route|
        route[http_verb]
      end.compact
    end

    def routes
      @routes ||= JSON.load(File.open(@routes_filename))['routes']
    end

  end
end
