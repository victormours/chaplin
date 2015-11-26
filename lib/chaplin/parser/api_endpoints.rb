require_relative '../api_endpoint'

class Chaplin

  module Parser

    class ApiEndpoints

      def self.valid?(raw_data_value)
        http_verbs = ['get ', 'post ', 'put ', 'head ', 'delete ']
        [raw_data_value].flatten.first.downcase.start_with?(*http_verbs)
      end

      def self.build(api_endpoint_declaration)
        new(api_endpoint_declaration).build
      end

      def initialize(api_endpoint_declaration)
        @api_endpoint_declaration = [api_endpoint_declaration].flatten
      end

      def build
        ApiEndpoint.new(http_method, path, params, headers)
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

      def headers
        @api_endpoint_declaration[2] || {}
      end

    end
  end
end

