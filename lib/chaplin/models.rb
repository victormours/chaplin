Endpoint = Struct.new(:http_method, :path)

Request = Struct.new(:params)

class ApiEndpoint < Endpoint

  def self.configure(api_url)
    @client = Faraday.new(api_url)
  end

  def self.client
    @client
  end

  def render(request)
    JSON.parse(api_response(params).body)
  end

  private

  def api_response(params)
    self.class.client.send(:http_method, :path, params)
  end
end

# data is a hash with symbols as keys and api endpoints or other pages as values
class Page < Struct.new(:template_path, :data)

  def embed_in_layout(layout_template_path, layout_data)
    @data = { content: Page.new(@template_path, @data) }.merge(layout_data)
    @template_path = layout_template_path
  end

  def render(request)
    page = Mustache.new
    page.template_file = @template_path
    page.render(rendered_data(request)
  end

  private

  def rendered_data(request)
    @data.each_with_object do |(key, value), rendered_data|
      rendered_data[key] = value.render(request)
    end
  end
end

Route = Struct.new(:endpoint, :page)

