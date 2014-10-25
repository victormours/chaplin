require 'faraday'

require_relative 'endpoint'

class Chaplin
  class ApiEndpoint < Struct.new(:http_method, :path, :forward_params)

    def self.configure(api_url)
      @@client = Faraday.new(api_url)
    end

    def self.client
      @@client
    end

    def render(request)
      JSON.parse(api_response(request).body)
    end

    private

    def api_response(request)
      params = forward_params && request.params
      self.class.client.send(http_method, path, params)
    end
  end
end

