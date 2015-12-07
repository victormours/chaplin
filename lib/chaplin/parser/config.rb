require 'json'

class Chaplin
  module Parser

    Config = Struct.new(:project_path) do

      DEFAULT_API_URL = "http://localhost:8080"

      def api_url
        Mustache.render(raw_api_url, env: ENV)
      end

      def default_headers
        config['headers']
      end

      def basic_auth
        config['api_basic_auth']
      end

      private

      def raw_api_url
        config['api_url'] || DEFAULT_API_URL
      end

      def config
        DeclarationFile.app_declaration(project_path)
      end

    end
  end
end
