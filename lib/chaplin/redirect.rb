class Chaplin

  Redirect = Struct.new(:redirect_path, :api_requests) do

    def execute(request_params, sinatra_server)
      api_requests.each do |api_request| api_request.render(request_params) end
      sinatra_server.redirect(rendered_path(request_params))
    end

    private

    def rendered_path(request_params)
      Mustache.render(redirect_path, request_params)
    end

  end
end
