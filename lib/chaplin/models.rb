class Chaplin

  Endpoint = Struct.new(:http_method, :path)

  Route = Struct.new(:endpoint, :page)
  Request = Struct.new(:params)


  class ApiEndpoint < Endpoint

    def self.configure(api_url)
      @client = Faraday.new(api_url)
    end

    def self.client
      @client
    end

    def render(request)
      JSON.parse(api_response(params).body)
    end

    private

    def api_response(params)
      self.class.client.send(:http_method, :path, params)
    end
  end
end

