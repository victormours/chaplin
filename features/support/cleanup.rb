After do
  `rm -rf tmp/*`
  @chaplin_server.stop if @chaplin_server
  @api_server.stop if @api_server

  if @api_pid
    `kill -9 #{@api_pid}`
  end
end
