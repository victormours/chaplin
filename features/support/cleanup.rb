After do
  `rm -rf tmp/*`
  @chaplin_server.stop
  @api_server.stop if @api_server

  if @api_pid
    `kill -9 #{@api_pid}`
  end
end
