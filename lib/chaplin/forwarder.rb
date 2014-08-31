require 'json'
require_relative 'api_client'

module Chaplin
  class Forwarder

    def initialize(api_url)
      @api_url = api_url
      @api_client = APIClient.new(api_url)
    end

    def forward(chaplin_request, api_requests)
      {}.tap do |api_data|
        api_requests.each do |data_key, api_endpoint|
          api_data[data_key] = api_response(chaplin_request, api_endpoint)
        end
      end
    end


    def cookie_header
      @api_client.cookie_header
    end

    private

    def api_response(chaplin_request, api_endpoint)
      JSON.parse(@api_client.forward(chaplin_request, api_endpoint).body)
    end

  end
end
