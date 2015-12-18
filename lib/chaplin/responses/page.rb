require 'mustache'

class Chaplin
  module Responses

    # data is a hash with symbols as keys and api endpoints or other pages as values
    Page = Struct.new(:template_path, :data) do

      def execute(request_params, sinatra_server)
        render(request_params)
      end

      def render(request_params)
        page = Mustache.new
        page.template_file = template_path
        page.render(File.read(template_path), response_data(request_params))
      end

      private

      def response_data(request_params)
        Struct.new(:request_params, :data) do
          def params
            request_params
          end

          def respond_to?(method, include_private = false)
            super || data.keys.include?(method)
          end

          def method_missing(method_name)
            data[method_name].render(request_params)
          end

        end.new(request_params, data)
      end

      def rendered_data(request_params)
        data.each_with_object({}) do |(key, response), rendered_data|
          rendered_data[key] = response.render(request_params)
        end
      end
    end
  end
end

