require 'net/http'
require 'json'

module Chaplin
  class Forwarder

    def initialize(api_url)
      @api_url = api_url
    end

    def forward(request)
      uri = uri(request)

      api_request = nil
      case request.request_method
      when 'GET'
        api_request = Net::HTTP::Get.new(uri)
      when 'POST'
        api_request = Net::HTTP::Post.new(uri)
        api_request.set_form_data(request.params)
      end

      api_request['Cookie'] = request.env['HTTP_COOKIE']
      Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(api_request)
      end
    end

    def forward_layout_request(request)
      uri = layout_uri(request)
      api_request = Net::HTTP::Get.new(uri)
      api_request['Cookie'] = request.env['HTTP_COOKIE']
      Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(api_request)
      end
    end

    private

    def layout_uri(request)
      URI('http://' + @api_url + "/profile")
    end

    def uri(request)
      URI('http://' + @api_url + request.path)
    end
  end
end
