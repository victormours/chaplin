require_relative 'chaplin/builders/config'
require_relative 'chaplin/builders/router'
require_relative 'chaplin/builders/pages'
require_relative 'chaplin/builders/redirects'
require_relative 'chaplin/server'
require_relative 'chaplin/api_endpoint'

class Chaplin


  def initialize(project_path)
    @project_path = project_path
    @config = Builders::Config.new(@project_path)
    @routes_filename = project_path + "/routes.json"
  end

  def server
    ApiEndpoint.configure(@config.api_url, @config.default_headers, @config.basic_auth)
    Server.setup(@project_path)
    build_server
    Server.new
  end

  private

  def build_server
    pages = Builders::Pages.load(pages_data, @project_path, layout_name)
    redirects = Builders::Redirects.load(redirects_data)
    router = Builders::Router.new(routes_json, pages, redirects)
    router.load_routes

    router.routes.each do |endpoint, response|
      Server.add_route(endpoint, response)
    end
  end

  def pages_data
    @pages_data ||= json_data['pages'] || []
  end

  def redirects_data
    json_data['redirects'] || {}
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

