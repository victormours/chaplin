require_relative 'chaplin/router'
require_relative 'chaplin/server'

class Chaplin

  def initialize(project_path)
    @project_path = project_path
  end

  # returns a Rack application
  def server
    Rack::File.new(@project_path + '/public')
  end

  private

  def load_server
    router.load_routes("#{@project_path}/routes.json")

    router.routes.each do |route|
      templates_server.add_route(route)
    end
  end

  def router
    @router = Router.new
  end

  def templates_server
    @templates_server = Server.new
  end
end

