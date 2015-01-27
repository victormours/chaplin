require 'mustache'

class Chaplin
  module Responses

    # data is a hash with symbols as keys and api endpoints or other pages as values
    Page = Struct.new(:template_path, :data) do

      def execute(request_params, sinatra_server)
        render(request_params, sinatra_server)
      end

      def render(request_params, sinatra_server)
        page = Mustache.new
        page.template_file = template_path
        page.render(rendered_data(request_params).merge({params: request_params, session: sinatra_server.cookies}))
      end

      private

      def rendered_data(request_params)
        data.each_with_object({}) do |(key, value), rendered_data|
          rendered_data[key] = value.render(request_params)
        end
      end
    end
  end
end

