require_relative 'api_endpoint'

class Chaplin

  ApiEndpoints = Struct.new(:raw_api_endpoint) do

    def self.build(raw_api_endpoint)
      new(raw_api_endpoint).build
    end

    def build
      ApiEndpoint.new(http_method, path, params)
    end

    private

    def http_method
      raw_api_endpoint.first
                      .split(" ").first
                      .downcase.to_sym
    end

    def path
      raw_api_endpoint.first.split(" ").last
    end

    def params
      raw_api_endpoint[1] || {}
    end

  end
end

