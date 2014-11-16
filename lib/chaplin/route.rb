class Route < Struct.new(:endpoint, :page)

  def execute(request)
    page.render(request)
  end
end

