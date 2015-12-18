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
        response_class = Struct.new(:request_params, :data)

        data.each do |key,value|
          response_class.send(:define_method, key.to_sym) do
            data[key].render(request_params)
          end
        end

        response = response_class.new(request_params, data)

        def response.params
          request_params
        end

        response
      end

      def rendered_data(request_params)
        data.each_with_object({}) do |(key, response), rendered_data|
          rendered_data[key] = response.render(request_params)
        end
      end
    end
  end
end

