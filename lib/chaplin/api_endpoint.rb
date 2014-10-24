require 'faraday'

require_relative 'endpoint'

class Chaplin
  class ApiEndpoint < Endpoint

    def self.configure(api_url)
      @@client = Faraday.new(api_url)
    end

    def self.client
      @@client
    end

    def render(request)
      JSON.parse(api_response({}).body)
    end

    private

    def api_response(params)
      self.class.client.send(http_method, path, params)
    end
  end
end

