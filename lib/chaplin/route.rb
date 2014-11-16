class PageRoute < Struct.new(:endpoint, :page)

  def execute(request, sinatra_server)
    page.render(request)
  end
end

class RedirectRoute < Struct.new(:endpoint, :redirect_path)

  def execute(request, sinatra_server)
    sinatra_server.redirect(redirect_path)
  end
end
