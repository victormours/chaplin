require_relative '../redirect'
require_relative 'api_endpoints'

class Chaplin
  module Builders

    Redirects = Struct.new(:raw_redirect_data) do

      def self.load(raw_redirect_data)
        new(raw_redirect_data).load
      end

      def load
        raw_redirect_data.each_with_object({}) do |(redirect_name, redirect_data), redirects_hash|
          redirects_hash[redirect_name.to_s] = Redirect.new(redirect_data.first, api_requests(redirect_data[1]))
        end
      end

      private

      def api_requests(raw_requests_data)
        raw_requests_data.map do |raw_request|
          ApiEndpoints.build(raw_request)
        end
      end

    end
  end
end
