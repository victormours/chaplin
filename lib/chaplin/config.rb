require 'json'

class Chaplin
  class Config < Struct.new(:project_path)

    DEFAULT_API_URL = "http://localhost:8080"

    def initialize(project_path)
      @project_path = project_path
      @config_filename = project_path + "/chaplin_config.json"
    end

    def api_url
      config['api_url'] || DEFAULT_API_URL
    end

    def default_headers
      config['headers']
    end

    private

    def config
      @config ||= JSON.load(json_config)
    end

    def json_config
      File.open(@config_filename) rescue "{}"
    end

  end
end
