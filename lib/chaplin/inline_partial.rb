require 'mustache'

class Chaplin
  InlinePartial = Struct.new(:content) do

    def render(chaplin_request_params)
      full_params = chaplin_request_params.merge(env: ENV)
      Mustache.render(content, full_params)
    end

  end
end
