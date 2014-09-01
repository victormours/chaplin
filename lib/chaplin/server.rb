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
        api_data = @forwarder.forward(request, @router.data_for(request))
        response_body = @renderer.render(api_data, template_name)

        if @router.layout_name
          layout_api_data = @forwarder.forward(request, @router.layout_data)
          complete_data = layout_api_data.merge({ content: response_body })
          response_body = @renderer.render(complete_data, @router.layout_name)
        end

        status = 200
        headers = @forwarder.cookie_header || {}
        body = [response_body]

        [status, headers, body]
      else
        @file_server.call(rack_env)
      end
    end

  end
end
