require_relative '../api_endpoint'

class Chaplin

  module Parser

    class ApiEndpoints

      def self.build(api_endpoint_declaration)
        new(api_endpoint_declaration).build
      end

      def initialize(api_endpoint_declaration)
        @api_endpoint_declaration = [api_endpoint_declaration].flatten
      end

      def build
        ApiEndpoint.new(http_method, path, params)
      end

      private

      def http_method
        api_route.first.downcase.to_sym
      end

      def path
        api_route.last
      end

      def api_route
        @api_endpoint_declaration.first.split(" ")
      end

      def params
        @api_endpoint_declaration[1] || {}
      end

    end
  end
end

