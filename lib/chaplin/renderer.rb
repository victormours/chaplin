require 'mustache'
require_relative 'forwarder.rb'

module Chaplin
  class Renderer

    def initialize(templates_path)
      @templates_path = templates_path
    end

    def render(json_data, template_name, layout_data)
      puts "rendering stuff"
      page = Mustache.new
      page.template_file = @templates_path + 'layout.html'
      page_data = layout_data.merge({ content: render_page(json_data, template_name) })
      page.render(page_data)
    end

    private

    def render_page(json_data, template_name)
      page = Mustache.new
      page.template_file = @templates_path + template_name
      page.render(json_data)
    end

  end
end
