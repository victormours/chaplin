require_relative '../responses/redirect'
require_relative 'api_endpoints'

class Chaplin
  module Parser

    Redirects = Struct.new(:redirect_declarations) do

      def self.load(redirect_declarations)
        new(redirect_declarations).load
      end

      def load
        redirect_declarations.each_with_object({}) do |(redirect_name, redirect_data), redirects_hash|
          redirects_hash[redirect_name.to_s] = Responses::Redirect.new(redirect_data['path'], api_requests(redirect_data['requests']))
        end
      end

      private

      def api_requests(raw_requests_data)
        raw_requests_data.each_with_object({}) do |(key, request_declaration), data_hash|
          data_hash[key] = ApiEndpoints.build(request_declaration)
        end
      end

    end
  end
end
