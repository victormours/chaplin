module Chaplin
  class Server

    def initialize(api_url)
      @router = Router.new("routes.json")
      @renderer = Renderer.new('templates/')
      @forwarder = Forwarder.new(api_url)
      @file_server = Rack::File.new('public')
    end

    def call(rack_env)
      request = Rack::Request.new(rack_env)
      template_name = @router.template_for(request)
      if template_name
        api_response = @forwarder.forward(request)
        api_data = JSON.parse(api_response.body)

        layout_response = @forwarder.forward_layout_request(request)
        layout_data = JSON.parse(layout_response.body)

        response_body = @renderer.render(api_data, template_name, layout_data)

        status = 200
        headers = rack_formatted_headers(api_response)
        body = [response_body]

        [status, headers, body]
      else
        @file_server.call(rack_env)
      end
    end

    private

    def rack_formatted_headers(response)
      if response.header['set-cookie']
        {'set-cookie' => response.header['set-cookie']}
      else
        {}
      end
    end

  end
end
