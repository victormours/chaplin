class PageRoute < Struct.new(:endpoint, :page)

  def execute(request_params, sinatra_server)
    page.render(request_params)
  end
end

class RedirectRoute < Struct.new(:endpoint, :redirect_path, :api_requests)

  def execute(request_params, sinatra_server)
    api_requests.each do |api_request| api_request.render(request_params) end
    sinatra_server.redirect(redirect_path)
  end
end
