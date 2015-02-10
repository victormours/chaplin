require 'mustache'

class Chaplin
  module Responses

    Redirect = Struct.new(:redirect_path, :api_requests_hash, :cookie_hash) do

      def execute(request_params, sinatra_server)
        rendered_api_data = rendered_data(request_params)

        set_cookies(sinatra_server, rendered_api_data)

        sinatra_server.redirect(rendered_path(rendered_api_data, request_params))
      end

      private

      def rendered_data(request_params)
        api_requests_hash.each_with_object({}) do |(key, value), rendered_data|
          rendered_data[key] = value.render(request_params)
        end
      end

      def set_cookies(sinatra_server, rendered_api_data)
        cookie_hash.each do |key, value|
          sinatra_server.cookies[key] = Mustache.render(value, rendered_api_data)
        end
      end

      def rendered_path(rendered_data, request_params)
        Mustache.render(redirect_path, rendered_data.merge(request_params))
      end

    end
  end
end
