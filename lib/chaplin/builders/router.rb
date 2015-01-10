require 'json'

require_relative '../endpoint'

class Chaplin
  module Builders

    class Router

      def initialize(routes_declarations, pages, redirects)
        @routes_declarations = routes_declarations
        @pages = pages
        @redirects = redirects
        @routes = {}
      end

      attr_accessor :routes

      def load_routes
        @routes_declarations.each do |endpoint, response|
          if redirect?(response)
            redirect_name = response.split(' ').last
            @routes[build_endpoint(endpoint)] = @redirects[redirect_name]
          else
            @routes[build_endpoint(endpoint)] = @pages[response]
          end
        end
      end

      private

      def redirect?(response)
        response.start_with?("redirect")
      end

      def build_endpoint(raw_endpoint_data)
        http_method = raw_endpoint_data.split(' ').first.downcase.to_sym
        path = raw_endpoint_data.split(' ').last
        Endpoint.new(http_method, path)
      end

    end
  end
end
