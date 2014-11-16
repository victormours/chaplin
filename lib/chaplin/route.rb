class PageRoute < Struct.new(:endpoint, :page)

  def execute(request, sinatra_server)
    page.render(request)
  end
end

class RedirectRoute < Struct.new(:endpoint, :redirect_path, :api_requests)

  def execute(request, sinatra_server)
    api_requests.each do |api_request| api_request.render(request) end
    sinatra_server.redirect(redirect_path)
  end
end
