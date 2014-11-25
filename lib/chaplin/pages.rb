require_relative 'page'
require_relative 'api_endpoints'

class Chaplin

  Pages = Struct.new(:pages_data, :project_path, :layout_name) do

    def self.load(pages_data, project_path, layout_name = nil)
      new(pages_data, project_path, layout_name).tap do |pages|
        pages.load
      end
    end

    def load
      @pages = {}

      pages_data.each do |template_name, raw_data_hash|
        @pages[template_name] = build_page(template_name, raw_data_hash)
      end
    end

    def [](page_name)
      @pages[page_name] || build_page(page_name, {})
    end

    private

    def build_page(template_name, raw_data_hash)
      Page.new(
        template_path(template_name),
        data_hash(raw_data_hash)
      ).tap do |page|
        page.embed_in_layout(layout_path) if layout_name
      end
    end

    def template_path(template_name)
      project_path + '/templates/' + template_name
    end

    def layout_path
      @layout_path ||= template_path(layout_name)
    end

    def data_hash(raw_data_hash)
      raw_data_hash.each_with_object({}) do |(key, raw_api_endpoint), data_hash|
        data_hash[key] = ApiEndpoints.build(raw_api_endpoint)
      end
    end

  end

end
