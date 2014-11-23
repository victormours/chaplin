require 'sinatra/base'

class Chaplin
  class Server < Sinatra::Base

    def self.setup(project_path)
      set :public_folder, project_path + '/public'
    end

    def self.add_route(endpoint, response)
      send(endpoint.http_method, endpoint.path) do
        response.execute(params, self)
      end
    end
  end
end
