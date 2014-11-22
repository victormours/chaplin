require 'mustache'

class Chaplin
  # data is a hash with symbols as keys and api endpoints or other pages as values
  class Page < Struct.new(:template_path, :data)

    def embed_in_layout(layout_template_path, layout_data = {})
      self.data = { content: Page.new(template_path, data) }.merge(layout_data)
      self.template_path = layout_template_path
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

