require 'net/http'

module Chaplin
  class APIClient

    def initialize(api_url)
      @api_url = api_url
      @cookie_header = nil
      @api_cookie = nil
    end

    def forward(request, api_endpoint)
      uri = uri(api_endpoint.path)

      api_request = nil
      case api_endpoint.http_method
      when 'GET'
        api_request = Net::HTTP::Get.new(uri)
      when 'POST'
        api_request = Net::HTTP::Post.new(uri)
        api_request.set_form_data(request.params)
      end

      api_request['Cookie'] = request.env['HTTP_COOKIE'] || @api_cookie
      Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(api_request).tap do |response|
          @cookie_header = response.header['set-cookie']
          if response.header['set-cookie']
            cookie_header = {'set-cookie' => response.header['set-cookie']}
            @api_cookie = response.header['set-cookie']
          end
        end
      end
    end

    attr_reader :cookie_header

    private

    def uri(path)
      URI('http://' + @api_url + path)
    end
  end
end
