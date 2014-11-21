require 'json'

require 'faraday'
require 'mustache'

require_relative 'endpoint'

class Chaplin
  class ApiEndpoint < Struct.new(:http_method, :path, :params)

    def initialize(http_method, path, params)
      super(http_method, path, params || {})
    end

    def self.configure(api_url, default_headers, basic_auth)
      @@client = Faraday.new(url: api_url) do |client|
        client.adapter Faraday.default_adapter
        if basic_auth
          client.basic_auth(basic_auth['user'], basic_auth['password'])
        end
      end
      @@default_headers = default_headers || {}
    end

    def render(request_params)
      response_body = api_response(request_params).body
      return nil if response_body == 'null'
      JSON.parse(response_body)
    end

    private

    def api_response(request_params)
      @@client.send(
        http_method,
        parsed_path(request_params),
        api_request_params(request_params),
        @@default_headers
      )
    end

    def api_request_params(chaplin_request_params)
      if json_request? && [:post, :put].include?(http_method)
        rendered_params(chaplin_request_params).to_json
      else
        rendered_params(chaplin_request_params)
      end
    end

    def json_request?
      @@default_headers['Content-Type'] == 'application/json'
    end

    def rendered_params(request_params)
      params.each_with_object({}) do |(key, value), rendered_params|
        rendered_params[key] = Mustache.render(value, request_params)
      end
    end

    def parsed_path(request_params)
      Mustache.render(path, request_params)
    end
  end
end

