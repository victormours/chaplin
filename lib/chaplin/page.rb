require 'mustache'

class Chaplin
  # data is a hash with symbols as keys and api endpoints or other pages as values
  class Page < Struct.new(:template_path, :data)

    def execute(request_params, sinatra_server)
      render(request_params)
    end

    def render(request_params)
      page = Mustache.new
      page.template_file = template_path
      page.render(rendered_data(request_params).merge({params: request_params}))
    end

    private

    def rendered_data(request_params)
      data.each_with_object({}) do |(key, value), rendered_data|
        rendered_data[key] = value.render(request_params)
      end
    end
  end
end

