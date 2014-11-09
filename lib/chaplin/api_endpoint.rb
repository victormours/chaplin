require 'faraday'
require 'mustache'

require_relative 'endpoint'

class Chaplin
  class ApiEndpoint < Struct.new(:http_method, :path, :params)

    def initialize(http_method, path, params = {})
      super(http_method, path, params)
    end

    def self.configure(api_url)
      @@client = Faraday.new(api_url)
    end

    def self.client
      @@client
    end

    def render(request)
      puts api_response(request).body
      JSON.parse(api_response(request).body)
    end

    private

    def api_response(request)
      self.class.client.send(http_method,
                             parsed_path(request),
                             rendered_params(request.params))
    end

    def rendered_params(request_params)
      params.each_with_object({}) do |(key, value), rendered_params|
        rendered_params[key] = Mustache.render(value, request_params)
      end
    end

    def parsed_path(request)
      Mustache.render(path, request.params)
    end
  end
end

