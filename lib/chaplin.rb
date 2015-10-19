require_relative 'chaplin/parser'
require_relative 'chaplin/parser/config'
require_relative 'chaplin/server'
require_relative 'chaplin/api_endpoint'

class Chaplin

  def initialize(project_path)
    @project_path = project_path
    @config = Parser::Config.new(@project_path)
  end

  def server
    ApiEndpoint.configure(@config.api_url, @config.default_headers, @config.basic_auth)
    Server.setup(@project_path)
    build_server
    setup_404_page
    Server.new
  end

  private

  def build_server
    Parser.routes(@project_path).each do |endpoint, response|
      Server.add_route(endpoint, response)
    end
  end

  def setup_404_page
    not_found_page = Parser.not_found_response(@project_path)

    return unless not_found_page

    Server.not_found do
      not_found_page.execute({}, Server)
    end
  end

end

