class Chaplin

  def initialize(project_path)
    @project_path = project_path
  end

  # returns a Rack application
  def server
    Rack::File.new(@project_path + '/public')
  end
end

