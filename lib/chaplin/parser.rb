require_relative 'parser/config'
require_relative 'parser/router'
require_relative 'parser/pages'
require_relative 'parser/redirects'

class Chaplin
  module Parser

    def self.routes(project_path)
      @@project_path = project_path
      pages = Pages.load(pages_declaration, project_path, layout_name)
      redirects = Redirects.load(redirects_declaration)
      router = Router.new(routes_json, pages, redirects)
      router.load_routes
      router.routes
    end

    private

    def self.pages_declaration
      app_declaration['pages'] || []
    end

    def self.redirects_declaration
      app_declaration['redirects'] || {}
    end

    def self.layout_name
      app_declaration['layout']
    end

    def self.routes_json
      app_declaration['routes']
    end

    def self.app_declaration
      @@app_declaration ||= JSON.load(File.open(@@project_path + "/routes.json"))
    end

  end
end
