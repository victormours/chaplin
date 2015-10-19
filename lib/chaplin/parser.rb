require_relative 'parser/declaration_file'
require_relative 'parser/router'
require_relative 'parser/pages'
require_relative 'parser/redirects'

class Chaplin
  module Parser

    def self.routes(project_path)
      parser.routes(project_path)
    end

    def self.parser
      Object.new.extend(self)
    end

    def routes(project_path)
      self.project_path = project_path
      Router.new(routes_declaration, pages, redirects).routes
    end

    def self.not_found_response(project_path)
      parser.not_found_response(project_path)
    end

    def not_found_response(project_path)
      self.project_path = project_path
      return unless DeclarationFile.new(project_path).not_found_page
      pages[DeclarationFile.new(project_path).not_found_page]
    end

    private

    attr_accessor :project_path

    def pages
      @pages ||= Pages.load(pages_declaration, project_path, layout_name)
    end

    def redirects
      Redirects.load(redirects_declaration)
    end

    def pages_declaration
      app_declaration['pages'] || []
    end

    def redirects_declaration
      app_declaration['redirects'] || {}
    end

    def layout_name
      app_declaration['layout']
    end

    def routes_declaration
      app_declaration['routes']
    end

    def app_declaration
      @app_declaration ||= DeclarationFile.app_declaration(project_path)
    end

  end
end
