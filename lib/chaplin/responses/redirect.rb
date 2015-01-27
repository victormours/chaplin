require 'mustache'

class Chaplin
  module Responses

    Redirect = Struct.new(:redirect_path, :api_requests_hash) do

      def execute(request_params, sinatra_server)
        sinatra_server.redirect(rendered_path(request_params))
      end

      private

      def rendered_path(request_params)
        Mustache.render(redirect_path, rendered_data(request_params).merge(request_params))
      end

      def rendered_data(request_params)
        api_requests_hash.each_with_object({}) do |(key, value), rendered_data|
          rendered_data[key] = value.render(request_params)
        end
      end

    end
  end
end
