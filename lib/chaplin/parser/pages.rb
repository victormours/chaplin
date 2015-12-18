require_relative '../responses/page'
require_relative '../inline_partial'
require_relative 'api_endpoints'

class Chaplin
  module Parser

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

        return unless layout_name
        @pages = @pages.each_with_object({}) do |(page_name, page), pages_in_layout|
          pages_in_layout[page_name] = embed_in_layout(page)
        end
      end

      def [](page_name)
        @pages[page_name] || build_templated_page(page_name)
      end

      private

      def embed_in_layout(page)
        Responses::Page.new(layout_path, { content: page })
      end

      def build_page(template_name, raw_data_hash)
        Responses::Page.new(template_path(template_name), data_hash(raw_data_hash))
      end

      def build_templated_page(page_name, raw_data_hash: {})
        page = build_page(page_name, raw_data_hash)
        layout_name ? embed_in_layout(page) : page
      end

      def template_path(template_name)
        project_path + '/templates/' + template_name
      end

      def layout_path
        @layout_path ||= template_path(layout_name)
      end

      def data_hash(raw_data_hash)
        raw_data_hash.each_with_object({}) do |(key, raw_data_value), data_hash|
          data_hash[key.to_sym] = build_data(raw_data_value)
        end
      end

      def build_data(raw_data_value)
        if partial?(raw_data_value)
          partial_name = raw_data_value.split(" ").last
          @pages[partial_name]
        elsif endpoint?(raw_data_value)
          ApiEndpoints.build(raw_data_value)
        else
          InlinePartial.new(raw_data_value)
        end
      end

      def partial?(raw_data_value)
        raw_data_value.is_a?(String) && raw_data_value.downcase.start_with?("render")
      end

      def endpoint?(raw_data_value)
        ApiEndpoints.valid?(raw_data_value)
      end

    end

  end
end
