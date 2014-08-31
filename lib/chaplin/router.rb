require 'json'
require_relative 'endpoint'

module Chaplin

  Route = Struct.new(:method, :path, :template, :data)

  class Router

    def initialize(routes_filename)
      @routes_filename = routes_filename
    end

    def template_for(request)
      route_for(request) && route_for(request).template
    end

    def data_for(request)
      {}.tap do |data|
        route_for(request).data.each do |data_key, endpoint|
          data[data_key] = Endpoint.new(endpoint.first, endpoint.last)
        end
      end
    end

    def layout_name
      layout && layout.first
    end

    def layout_data
      return unless layout

      {}.tap do |data|
        layout.last.each do |data_key, endpoint|
          data[data_key] = Endpoint.new(endpoint.first, endpoint.last)
        end
      end
    end

    private

    def route_for(request)
      routes.find do |route|
        route.method == request.request_method &&
          route.path == request.path
      end
    end

    def routes
      @routes ||= routes_json.map do |route|
        Route.new(route[0], route[1], route[2], route[3])
      end
    end

    def routes_json
      @routes_json ||= JSON.load(File.open(@routes_filename))['routes']
    end

    def layout
      @layout ||= JSON.load(File.open(@routes_filename))['layout']
    end

  end
end
