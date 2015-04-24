require 'json'

require_relative '../endpoint'

class Chaplin
  module Parser

    class Router

      def initialize(routes_declarations, pages, redirects)
        @routes_declarations = routes_declarations
        @pages = pages
        @redirects = redirects
      end

      def routes
        {}.tap do |routes|
          @routes_declarations.each do |endpoint, response_name|
            routes[build_endpoint(endpoint)] = response(response_name)
          end
        end
      end

      private

      def response(response_name)
        if redirect?(response_name)
          redirect_name = response_name.split(' ').last
          @redirects[redirect_name]
        else
          @pages[response_name]
        end
      end

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
