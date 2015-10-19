require 'pathname'
require 'json'
require 'yaml'

class Chaplin
  module Parser
    DeclarationFile = Struct.new(:project_path) do

      def self.app_declaration(project_path)
        new(project_path).app_declaration
      end

      def app_declaration
        load_json || load_yaml || no_file_found
      end

      def not_found_page
        app_declaration[404]
      end

      private

      def load_json
        if File.exists?(json_filename)
          JSON.load(File.open(json_filename))
        end
      end

      def json_filename
        project_path + "/routes.json"
      end

      def load_yaml
        if File.exists?(yml_filename)
          YAML.load_file(yml_filename)
        end
      end

      def yml_filename
        project_path + "/app.yml"
      end

      def no_file_found
        raise "Could not find #{yml_filename} or #{json_filename}"
      end

    end
  end
end
