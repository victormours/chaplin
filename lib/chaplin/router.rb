require 'json'

require_relative 'server/endpoint'
require_relative 'builder/pages'
require_relative 'redirects'

class Chaplin

  class Router

    def initialize(project_path)
      @project_path = project_path
      @routes_filename = project_path + "/routes.json"
      @routes = {}
    end

    attr_accessor :routes

    def load_routes
      pages = Pages.load(pages_data, @project_path, layout_name)
      redirects = Redirects.load(redirects_data)

      routes_json.each do |raw_endpoint_data, response|
        if response.start_with?("redirect")
          response_name = response.split(' ').last
          @routes[endpoint(raw_endpoint_data)] = redirects[response_name]
        else
          @routes[endpoint(raw_endpoint_data)] = pages[response]
        end
      end
    end

    private

    def endpoint(raw_endpoint_data)
      http_method = raw_endpoint_data.split(' ').first.downcase.to_sym
      path = raw_endpoint_data.split(' ').last
      Endpoint.new(http_method, path)
    end

    def pages_data
      @pages_data ||= json_data['pages'] || []
    end

    def templates_path
      @project_path + '/templates/'
    end

    def layout_name
      @layout_name ||= json_data['layout']
    end

    def redirects_data
      json_data['redirects'] || {}
    end

    def routes_json
      @routes_json ||= json_data['routes']
    end

    def json_data
      @json_data ||= JSON.load(File.open(@routes_filename))
    end

  end
end
