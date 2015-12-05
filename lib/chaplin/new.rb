class Chaplin
  module New

    def self.call(new_project_path)
      FileUtils.mkdir(new_project_path)
      FileUtils.cp_r("#{__dir__}/../../sample_project/templates", new_project_path)
      FileUtils.cp("#{__dir__}/../../sample_project/app.yml", new_project_path)
      FileUtils.cp("#{__dir__}/../../sample_project/chaplin_config.yml", new_project_path)
    end

  end
end
