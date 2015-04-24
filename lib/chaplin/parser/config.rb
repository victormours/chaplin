require 'json'

class Chaplin
  module Parser

    Config = Struct.new(:project_path) do

      DEFAULT_API_URL = "http://localhost:8080"

      def api_url
        config['api_url'] || DEFAULT_API_URL
      end

      def default_headers
        config['headers']
      end

      def basic_auth
        config['basic_auth']
      end

      private

      def config
        @config ||= load_yaml || load_json || {}
      end

      def load_yaml
        if File.exists?(yaml_filename)
          YAML.load_file(yaml_filename)
        end
      end

      def yaml_filename
        "#{project_path}/chaplin_config.yml"
      end

      def load_json
        if File.exists?(json_filename)
          JSON.load(File.open(json_filename))
        end
      end

      def json_filename
        "#{project_path}/chaplin_config.json"
      end

    end
  end
end
