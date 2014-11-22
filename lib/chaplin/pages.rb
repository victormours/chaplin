require_relative 'page'
require_relative 'api_endpoint'

class Chaplin

  Pages = Struct.new(:pages_data, :layout_name) do

    def self.load(pages_data, layout_name = nil)
      new(pages_data, layout_name).tap do |pages|
        pages.load
      end
    end

    def load
      @pages = {}

      pages_data.each do |template_name, raw_data_hash|
        page =  Page.new(template_name, data_hash(raw_data_hash))
        page.embed_in_layout(layout_name) if layout_name
        @pages[template_name] = page
      end
    end

    def [](page_name)
      @pages[page_name]
    end

    private

    def data_hash(raw_data_hash)
      raw_data_hash.each_with_object({}) do |(key, raw_api_endpoint), data_hash|
        data_hash[key] = api_endpoint(raw_api_endpoint)
      end
    end

    def api_endpoint(raw_api_endpoint)
      ApiEndpoint.new(http_method(raw_api_endpoint),
                      path(raw_api_endpoint),
                      params(raw_api_endpoint))
    end

    def http_method(raw_api_endpoint)
      raw_api_endpoint.first
                      .split(" ").first
                      .downcase.to_sym
    end

    def path(raw_api_endpoint)
      raw_api_endpoint.first.split(" ").last
    end

    def params(raw_api_endpoint)
      raw_api_endpoint.last
    end

  end

end
