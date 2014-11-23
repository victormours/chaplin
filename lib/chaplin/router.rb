require 'json'

require_relative 'route'
require_relative 'endpoint'
require_relative 'api_endpoint'
require_relative 'pages'

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

      routes_json.each do |raw_endpoint_data, response|
        @routes[endpoint(raw_endpoint_data)] = pages[response]
      end
    end

    private

    def endpoint(raw_endpoint_data)
      http_method = raw_endpoint_data.split(' ').first.downcase.to_sym
      path = raw_endpoint_data.split(' ').last
      Endpoint.new(http_method, path)
    end

    # def add_route(json_route)
      # endpoint = Endpoint.new(json_route[0].downcase.to_sym, json_route[1])
    #
    #   route = nil
    #   if json_route[2].start_with?("redirect ")
    #     redirect_path = json_route[2].split(' ').last
    #
    #     api_endpoints = json_route[3].map do |json_endpoint|
    #       api_endpoint(json_endpoint)
    #     end
    #     route = RedirectRoute.new(endpoint, redirect_path, api_endpoints)
    #   else
    #     page = Page.new(templates_path + json_route[2], data_hash(json_route[3]))
    #     page.embed_in_layout(templates_path + layout_name, {}) if layout_name
    #     route = PageRoute.new(endpoint, page)
    #   end
    #
    #   @routes << route
    # end
    #
    # def data_hash(json_hash)
    #   json_hash.each_with_object({}) do |(key, json_endpoint), data_hash|
    #     data_hash[key] = api_endpoint(json_endpoint)
    #   end
    # end
    #
    # def api_endpoint(json_endpoint)
    #   ApiEndpoint.new(json_endpoint[0].downcase.to_sym,
    #                   json_endpoint[1],
    #                   json_endpoint[2])
    # end
    #

    def pages_data
      @pages_data ||= json_data['pages'] || []
    end

    def templates_path
      @project_path + '/templates/'
    end

    def layout_name
      @layout_name ||= json_data['layout']
    end

    def routes_json
      @routes_json ||= json_data['routes']
    end

    def json_data
      @json_data ||= JSON.load(File.open(@routes_filename))
    end

  end
end
