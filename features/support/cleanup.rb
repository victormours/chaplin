After do
  # `rm -r tmp/*`
  @chaplin_server.stop

  if @api_pid
    `kill -9 #{@api_pid}`
  end
end
