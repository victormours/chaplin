require 'sinatra/base'
require "sinatra/cookies"

class Chaplin
  class Server < Sinatra::Base
    helpers Sinatra::Cookies

    def self.setup(project_path)
      set :public_folder, project_path + '/public'
      set :static_cache_control, [:public, :max_age => 300]

      set :show_exceptions, false

      error do
        env['sinatra.error'].message + "\n" + env['sinatra.error'].backtrace.join("\n")
      end
    end

    def self.add_route(endpoint, response)
      send(endpoint.http_method, endpoint.path) do
        params_with_cookies_and_session = (params || {}).merge(cookies: cookies, session: session)
        response.execute(params_with_cookies_and_session, self)
      end
    end
  end
end
