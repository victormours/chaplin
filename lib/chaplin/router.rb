require 'json'

require_relative 'route'
require_relative 'endpoint'
require_relative 'api_endpoint'
require_relative 'page'

class Chaplin

  class Router

    def initialize(project_path)
      @project_path = project_path
      @routes_filename = project_path + "/routes.json"
      @routes = []
    end

    attr_accessor :routes

    def load_routes
      routes_json.each do |route|
        add_route(route)
      end
    end

    private

    def add_route(route)
      endpoint = Endpoint.new(route[0].downcase.to_sym, route[1])
      page = Page.new(templates_path + route[2], data_hash(route[3]))
      if layout_name
        page.embed_in_layout(templates_path + layout_name, {})
      end
      @routes << Route.new(endpoint, page)
    end

    def data_hash(json_hash)
      json_hash.each_with_object({}) do |(key, json_endpoint), data_hash|
        data_hash[key] = api_endpoint(json_endpoint)
      end
    end

    def api_endpoint(json_endpoint)
      ApiEndpoint.new(json_endpoint[0].downcase.to_sym,
                      json_endpoint[1],
                      json_endpoint[2] == "forward_params")
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
