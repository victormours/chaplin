Feature: Cookies

  You'll need to use a Rack middleware to write cookies, however you can read them anywhere you can read request params, using the `cookies` key. For example, this is how you can add an oauth token to a requets:
  """
  routes:
    GET /: index.html

  pages:
    index.html:
      user:
        - GET /me
        - {}
        - Authorization: 'Bearer {{cookies.token}}'
  """

