require 'sinatra/base'
require_relative 'request'

class Chaplin
  class Server < Sinatra::Base

    def self.setup(project_path)
      set :public_folder, project_path + '/public'
    end

    def self.add_route(route)
      endpoint = route.endpoint

      send(endpoint.http_method, endpoint.path) do
        request = Request.new(params)
        route.execute(request, self)
      end
    end
  end
end
