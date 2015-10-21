require 'json'

require 'faraday'
require 'mustache'

require_relative 'endpoint'

class Chaplin
  ApiEndpoint = Struct.new(:http_method, :path, :params, :headers) do

    def initialize(http_method, path, params, headers = {})
      super(http_method, path, params || {}, headers)
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

    def render(chaplin_request_params)
      full_params = chaplin_request_params.merge(env: ENV)
      response_body = api_response(full_params).body
      return nil if (response_body == 'null' or response_body == '')
      JSON.parse(response_body)
    end

    private

    def api_response(full_params)
      @@client.send(
        http_method,
        parsed_path(full_params),
        api_request_params(full_params),
        @@default_headers
      )
    end

    def api_request_params(full_params)
      if json_request? && [:post, :put, :patch].include?(http_method)
        Mustache.render(params.to_json, full_params)
      else
        rendered_params(full_params)
      end
    end

    def json_request?
      request_headers['Content-Type'] == 'application/json'
    end

    def request_headers
      @@default_headers.merge(headers)
    end

    def rendered_params(full_params)
      params.each_with_object({}) do |(key, value), rendered_params|
        rendered_params[key] = Mustache.render(value, full_params)
      end
    end

    def parsed_path(full_params)
      Mustache.render(path, full_params)
    end
  end
end

