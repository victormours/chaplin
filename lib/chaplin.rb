require_relative 'chaplin/router'
require_relative 'chaplin/server'

class Chaplin


  def initialize(project_path)
    @project_path = project_path
  end

  # returns a Rack application
  def server
    Server.setup(@project_path)
    load_server
    templates_server
  end

  private

  def load_server
    router.load_routes

    router.routes.each do |route|
      Server.add_route(route)
    end
  end

  def router
    @router ||= Router.new(@project_path)
  end

  def templates_server
    @templates_server ||= Server.new
  end
end

