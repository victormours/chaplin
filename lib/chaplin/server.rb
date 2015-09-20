require 'sinatra/base'
require "sinatra/cookies"

class Chaplin
  class Server < Sinatra::Base
    helpers Sinatra::Cookies

    def self.setup(project_path)
      set :public_folder, project_path + '/public'
    end

    def self.add_route(endpoint, response)
      send(endpoint.http_method, endpoint.path) do
        params = (params || {}).merge(cookies: cookies)
        response.execute(params, self)
      end
    end
  end
end
